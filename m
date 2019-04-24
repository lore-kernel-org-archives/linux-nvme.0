From: info@metux.net (Enrico Weigelt, metux IT consult)
Date: Wed, 24 Apr 2019 12:34:38 +0200
Subject: libata fixes for NVME + OPAL
Message-ID: <1556102081-11820-1-git-send-email-info@metux.net>

Hello folks,


here're some fixes for libata to make NVME and TCG OPAL work:

* fix a little build break in nvme (forgotten include and Kconfig select)
* introduce sysctl knob for enabling tpm stuff at runtime
  (sed-util expects since several years, so it seems that piece just might
  have been forgotten when opal support was mainlined)


--mtx
