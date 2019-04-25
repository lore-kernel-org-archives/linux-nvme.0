From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Apr 2019 23:51:36 +0900
Subject: [PATCH 0/2] nvme: Check size of command structures
In-Reply-To: <20190425144408.GA17039@lst.de>
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
 <20190425144408.GA17039@lst.de>
Message-ID: <5b496881-36ab-fff4-4200-efd4aeb059e7@gmail.com>

On 4/25/19 11:44 PM, Christoph Hellwig wrote:
> I'm not sure we are going a little too crazy with all these
> BUILD_BUG_ONs.  It would be a lot easier if we could just throw
> the assert into the struct defintion somehow, but that would need
> compiler magic..

Agreed.. But we can have it to prevent mis-size issues unless we have
that magic. ;)

Thanks,
