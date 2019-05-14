From: hch@lst.de (Christoph Hellwig)
Date: Tue, 14 May 2019 07:20:27 +0200
Subject: PROBLEM: call trace triggered in 5.1.1 in
 drivers/nvme/host/pci.c, 5.0.11 ok
In-Reply-To: <CAC=wYCGgPQPjUUjQTZh4H7b8WRQFGmbKCBRAq75g1BXjBR0L0Q@mail.gmail.com>
References: <CAC=wYCGgPQPjUUjQTZh4H7b8WRQFGmbKCBRAq75g1BXjBR0L0Q@mail.gmail.com>
Message-ID: <20190514052027.GB6294@lst.de>

Hi Adam,

thanks for the report!

> [  145.788972] ------------[ cut here ]------------

Actually despite that "cut here" marker the most relevant information
is just above that.   Can you just then the full output from dmesg?
