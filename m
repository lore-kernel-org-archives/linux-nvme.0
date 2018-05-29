From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 10:11:17 +0200
Subject: [PATCH] nvme: prefer strlcpy to strncpy
In-Reply-To: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>
References: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>
Message-ID: <20180529081117.GA1416@lst.de>

On Mon, May 28, 2018@11:49:18PM -0700, Nick Desaulniers wrote:
> Fixes a stringop-truncation warning from gcc-8.

What would that warning be?  Maybe it actually is genuinly useful,
and switching to strlcpy just papers over it..
