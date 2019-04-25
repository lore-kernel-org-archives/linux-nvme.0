From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Apr 2019 08:38:55 -0700
Subject: [PATCH 0/2] nvme: Check size of command structures
In-Reply-To: <20190425144408.GA17039@lst.de>
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
 <20190425144408.GA17039@lst.de>
Message-ID: <1556206735.161891.146.camel@acm.org>

On Thu, 2019-04-25@16:44 +0200, Christoph Hellwig wrote:
> I'm not sure we are going a little too crazy with all these
> BUILD_BUG_ONs.  It would be a lot easier if we could just throw
> the assert into the struct defintion somehow, but that would need
> compiler magic..

How about something like the following just after each structure definition?

static inline void nvmf_common_command_size_check(void)
{
        BUILD_BUG_ON(sizeof(struct nvmf_common_command) != 64);
}

Bart.
