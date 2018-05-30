From: nick.desaulniers@gmail.com (Nick Desaulniers)
Date: Tue, 29 May 2018 19:02:29 -0700
Subject: [PATCH] nvme: prefer strlcpy to strncpy
In-Reply-To: <20180529081117.GA1416@lst.de>
References: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>
 <20180529081117.GA1416@lst.de>
Message-ID: <CAH7mPvgC7WE-JFUk3aV4_Cex9vm9PO9wRa7gM8-=YdUp5uOv4Q@mail.gmail.com>

On Tue, May 29, 2018@1:11 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, May 28, 2018@11:49:18PM -0700, Nick Desaulniers wrote:
>> Fixes a stringop-truncation warning from gcc-8.
>
> What would that warning be?  Maybe it actually is genuinly useful,
> and switching to strlcpy just papers over it..

Eric also pointed out to me that strlcpy will not initialize the rest
of dest with zeros if size is less than the length of src.
