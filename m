From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 28 Nov 2017 05:04:11 -0800
Subject: [PATCH] nvme-cli: add new HMB identify fields of TP 4002
In-Reply-To: <CAA7jztfaOPPMONxSZi+uMbdFAMqmxE7cESpX4kFH_-36R1FQSg@mail.gmail.com>
References: <1511870207-17033-1-git-send-email-minwoo.im.dev@gmail.com>
 <20171128123736.GA1736@infradead.org>
 <CAA7jztfaOPPMONxSZi+uMbdFAMqmxE7cESpX4kFH_-36R1FQSg@mail.gmail.com>
Message-ID: <20171128130411.GA1822@infradead.org>

On Tue, Nov 28, 2017@09:58:59PM +0900, Minwoo Im wrote:
> I'm sorry for making confusions because of the numbering of reserved field.
> It should be started with 338 instead of 332.
> 
> The following patch will be good to be reviewed.

To make things easier it might be a good idea to start by copying
over nvme.h from the kernel as a first commit.
