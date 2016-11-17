From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 02:30:44 -0800
Subject: [PATCH 3/5] nvme.h: add Write Zeroes definitions
In-Reply-To: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>
References: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>
Message-ID: <20161117103044.GD8295@infradead.org>

On Tue, Nov 15, 2016@11:06:58PM -0800, chaitany kulkarni wrote:
> Add the command structure, optional command set support (ONCS) bit and
> a new error code for the Write Zeroes command.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>

Unlike the other patches this one looks white space damaged by a mail
client (and it also arrived out of sequence).

With the whitespaces fixed up this looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
