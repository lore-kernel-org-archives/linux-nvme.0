From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 29 Mar 2016 00:03:28 -0700
Subject: nvme device timeout
In-Reply-To: <20160328225411.GB27195@localhost.localdomain>
References: <CAHOCc18wCgprYh1k0m0ow1FhU51J-1JN-X2Fj-8VKHDVi-Zo9Q@mail.gmail.com>
 <20160328172423.GA22481@localhost.localdomain>
 <36E8D38D6B771A4BBDB1C0D800158A51865EF73D@SSIEXCH-MB3.ssi.samsung.com>
 <20160328225411.GB27195@localhost.localdomain>
Message-ID: <20160329070328.GA8910@infradead.org>

On Mon, Mar 28, 2016@10:54:11PM +0000, Keith Busch wrote:
> As far as bringing the driver initiated polling back, we can talk about
> that. Do you have a real need for this feature?

IFF we have to do this it should be a quirk flag for specific
controllers that need a not spec compliant workaround.
