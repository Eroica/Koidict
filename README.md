# Koidict

*Koidict* is a lexicon for traditional Chinese based on the dictionary published by Taiwan's Ministry of Education (see https://www.moedict.tw/). It started out of the wish to help Chinese-learners that use platforms other than Windows or OS X/macOS. While it is of course possible to just use the website or the `node-webkit`-based wrapper, this program aims to bring a native interface and performance to Gtk+-based environments. Its interface is mostly based on OS X 10.9 "Maverick"'s *Dictionary.app*, with additional features gradually added to help especially those learning Chinese.

We are still heavily in the process of developing the first release, but a usable version will be available soon.

## Development

Koidict is written in **Vala**, and uses the Gtk+ toolkit. Right now a simple `Makefile` is used to create the binary, however this doesn't integrate well into a standard GNOME environment (the dictionary path needs to be hard-coded right now). Before we release, we plan to better integrate the program and the dictionary database into Linux' default paths.

Most dependencies already ship within a standard Vala distribution. You might need to separately install your package manager's `sqlite` package though.

Koidict is intended to be run on Gtk+-based environments, e.g. GNOME, but we plan to make it usable on other Linux environments as well. It's also already possible to run Koidict on OS X using Gtk+'s Mac bindings (in fact, this is partially the way how Koidict is being developed).

## License

Koidict is free software, licensed under the **GNU General Public License v3.0**. For more information, see the attached `LICENSE` file.

However, the dictionary data is not part of Koidict's code, and is published under a different license (see **Disclaimer**).

## Disclaimer

The dictionary database is provided by Taiwan’s Ministry of Education, and is licensed under [Creative Commons CC BY-ND 3.0](https://creativecommons.org/licenses/by-nd/3.0/):

```
=====================================================
編　　　輯　　　者：教育部國語推行委員會

國語推行委員會主任委員：童春發

編輯委員會主任委員：李　鍌

總　　　編　　　輯：李殿魁

副　總　編　輯　：曾榮汾


發　　行　　人：杜正勝

發　　行　　所：教育部

地　　　　　址：臺北市中山南路5號

電　　　　　話：(02)7736-6801
=====================================================
```
