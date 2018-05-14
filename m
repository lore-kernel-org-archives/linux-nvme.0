From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:35 +0200
Subject: dusted off ANA code
Message-ID: <20180514075646.28823-1-hch@lst.de>

As we had some ANA discussion I spent some hours over the weekend to dust off my
old ANA code.  It is mostly feature complete except for the lack of change state
handling on the host, but only very lightly tested in this form.  It also lacks
proper changelogs and testing..
