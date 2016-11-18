From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Fri, 18 Nov 2016 01:33:36 -0800
Subject: [PATCH 3/5] nvme.h: add Write Zeroes definitions
In-Reply-To: <20161117103044.GD8295@infradead.org>
References: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>
 <20161117103044.GD8295@infradead.org>
Message-ID: <CAK0tqikMTzZB=RtRW07fuepC1xWb=oBvqR0+FvwT4ifsNcm6+Q@mail.gmail.com>

I'll resend entire series with v2 prefix and add whitespaces fix along
with other comments.

On Thu, Nov 17, 2016@2:30 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 15, 2016@11:06:58PM -0800, chaitany kulkarni wrote:
>> Add the command structure, optional command set support (ONCS) bit and
>> a new error code for the Write Zeroes command.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
>
> Unlike the other patches this one looks white space damaged by a mail
> client (and it also arrived out of sequence).
>
> With the whitespaces fixed up this looks good:
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
