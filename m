From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 1 Nov 2017 10:50:36 -0600
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
Message-ID: <20171101165036.GD1030@ziepe.ca>

On Wed, Nov 01, 2017@06:02:38PM +0200, idanb wrote:

> (3) No send signal with invalidation signal w/o moderation 5.2M / 8.3M

Actually, isn't this valid and reasonable? You don't need to see the
SEND completion, the only thing that matters is the invalidate
completion, and the invalidate will naturally order after the send
is finished, yes?

Jason
