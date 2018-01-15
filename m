From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jan 2018 09:44:12 +0100
Subject: [PATCH 1/2] nvme: pci: replace magic number with readable size
 macro in hmb code
In-Reply-To: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20180115084412.GB32313@lst.de>

SZ_4K does not add any value at all.  The SZ constants may make some
size in the megabyte and larger ranges where the multiples of 1024
aren't totally obviously, but they certainly don't for 4 digit values.
