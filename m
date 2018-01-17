From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 17 Jan 2018 22:00:10 +0900
Subject: [PATCH 1/2] nvme: pci: replace magic number with readable size
 macro in hmb code
In-Reply-To: <20180115084412.GB32313@lst.de>
References: <1515930040-20561-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115084412.GB32313@lst.de>
Message-ID: <CAA7jztcR=QR0dBCa5mt3h4tk3wP5o5=cB95fHNpbQCqTs9ZVTg@mail.gmail.com>

On Mon, Jan 15, 2018@5:44 PM, Christoph Hellwig <hch@lst.de> wrote:
> SZ_4K does not add any value at all.  The SZ constants may make some
> size in the megabyte and larger ranges where the multiples of 1024
> aren't totally obviously, but they certainly don't for 4 digit values.

Christoph,

Thanks for giving your kind review.
Do you mean that SZ_* constants should _not_ be used to represent
small size like 4K?
