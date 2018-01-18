From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 19 Jan 2018 07:52:08 +0900
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <20180118113114.GA11093@localhost.localdomain>
References: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115020016.GB13580@localhost.localdomain>
 <CAA7jztd_Ewejj9DZJKeYRWPi6t-PKW3tB4SR7h+fBT_8ztv0aQ@mail.gmail.com>
 <e402e9f4-b884-df4b-3841-445ea38142d2@oracle.com>
 <CAA7jztfXAgo33NmmzvHu5dNyNKEkVzgqMWRR6FS4p3Etxx-i6g@mail.gmail.com>
 <20180118113114.GA11093@localhost.localdomain>
Message-ID: <CAA7jztcSsnjC0E_h=q0YqopzV7TDFwTjBsCXTqdkFp90S-in1Q@mail.gmail.com>

On Thu, Jan 18, 2018@8:31 PM, Keith Busch <keith.busch@intel.com> wrote:
>
> The API doesn't let us set the nr_hw_queues to 0. We'd have to free the
> tagset at that point, but we don't free it until the last open reference
> is dropped. I can't seem to recall why that's necessary but I'll stare
> at this a bit longer see if it makes sense. The memory the driver is
> holding onto is not really a big deal either way.

Thank you for your time, Keith.

I was wondering if I would have to clear the whole tagset or not.
But as you said, If the memory driver holds is not really important
and no one is
referring it then we can skip it.
