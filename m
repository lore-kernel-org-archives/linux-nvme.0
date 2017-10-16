From: jsmart2021@gmail.com (James Smart)
Date: Mon, 16 Oct 2017 07:37:48 -0700
Subject: [PATCH] nvmet: protect sqhd update by a lock
In-Reply-To: <20171016072145.wyrp2fyw2cx2grpf@linux-x5ow.site>
References: <20171013203800.24125-1-jsmart2021@gmail.com>
 <20171016072145.wyrp2fyw2cx2grpf@linux-x5ow.site>
Message-ID: <963d2bd1-1193-7961-eafe-862ddf6f7a91@gmail.com>

On 10/16/2017 12:21 AM, Johannes Thumshirn wrote:
> To me it looks a bit awkward why you're only protecting the RMW part but not
> the re-read below.
> 
> Could you please give some explanation why this is not needed?
> 
> Thanks,
> 	Johannes
> 

Agree, is a little awkward. But works fine. The re-read will contain at 
least the value that it was updated to under the lock. If it's actually 
the value of a simultaneous update that is one further, that's actually 
fine too - as sqhd isn't 1:1 with a cqe. Yes a cqe must contain the 
sqhd, but sqhd can increment independently from a particuluar cqe. Key 
is that sqhd itself must increment sanely so that whenever stamped in a 
cqe it's valid.

I have no problem recutting with the lock around the assignment if desired.

-- james
