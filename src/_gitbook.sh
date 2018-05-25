mkdir -p "../dist" && mkdir -p "../dist/gitbook" && mkdir -p "../dist/gitbook/img" && cp 00-introduction.md ../dist/gitbook/README.md && rm ../dist/gitbook/SUMMARY.md && touch ../dist/gitbook/SUMMARY.md;
echo "# Summary" >> ../dist/gitbook/SUMMARY.md;
for f in *.md ;
  do if [ "${f}" != "00-introduction.md" ];
  then echo "* [" `sed '1!d' ${f}` "](${f})" >> ../dist/gitbook/SUMMARY.md;
  fi;
done;
sed -ie 's/ # / /g' ../dist/gitbook/SUMMARY.md &&
for f in *.md ;
  do pandoc -f markdown ${f} --template=template.html -t html -s -o ../dist/gitbook/${f}.html  ;
done &&
for f in img/* ;
  do cp ${f} ../dist/gitbook/${f};
done &&
for f in *.md ;
  do echo "{% include \"${f}.html\" %}" > ../dist/gitbook/${f}  ;
done
