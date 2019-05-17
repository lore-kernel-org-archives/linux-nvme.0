From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 17 May 2019 02:45:45 -0700
Subject: [PATCH RFC 0/4] nvmet: add support for port based io priority
In-Reply-To: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190517094545.GA26412@infradead.org>

On Wed, May 15, 2019@08:21:04PM -0700, Chaitanya Kulkarni wrote:
> Any feedback is welcome, I'd like to understand if this approach is desirable,
> if not then what is the right way to use the io priorities on that target side
> so that NVMeOF target can take advantage of the scheduler infrastructure ?

I don't really see the point.  Why would we treat I/O differently
depending on which port it came into?  Until NVMe has an actually
working priority scheme trying to hack support into our infrastructure
seems rather futile.
