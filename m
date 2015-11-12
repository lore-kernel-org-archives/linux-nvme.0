From: vedant@lath.in (Vedant Lath)
Date: Thu, 12 Nov 2015 16:56:29 +0530
Subject: nvme: controller resets
In-Reply-To: <CAKajsGPAsZorLkmGmA8VF46-5ic9ER4Lduu8Z2AFuH2DzT-_xA@mail.gmail.com>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
 <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
 <20151111221433.GA11250@localhost.localdomain>
 <CAKajsGPAsZorLkmGmA8VF46-5ic9ER4Lduu8Z2AFuH2DzT-_xA@mail.gmail.com>
Message-ID: <CAKajsGNg4o8Rqvne3xzN2aT3FZ=Wtp2Q6t=mwK6yMhXq3wHqNg@mail.gmail.com>

On Thu, Nov 12, 2015@3:26 AM, Vedant Lath <vedant@lath.in> wrote:
> In both cases, the controller crashes when FLUSH and WRITE commands
> are in the queue at the same time.

On Thu, Nov 12, 2015@3:15 PM, Vedant Lath <vedant@lath.in> wrote:
> All WRITE commands done due to mkfs.btrfs have non-zero values for
> both prp1 and prp2 regardless of length. All of them succeed except
> the last one which is just after a FLUSH.

Sorry, I meant READ instead of WRITE here. It can't READ and FLUSH at
the same time.
