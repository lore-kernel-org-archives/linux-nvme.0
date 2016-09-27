From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 27 Sep 2016 08:55:42 -0700
Subject: [PATCH 5/9] block: Extend blk_freeze_queue_start() to the
 non-blk-mq path
In-Reply-To: <a8e8796e-7266-4c8a-a4eb-31cedf73ec8a@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <7c8af8d2-2ac9-2767-5e5f-8de72eba3814@sandisk.com>
 <CACVXFVO=GFp=ArC_FT+xPSmL84m01fX6bzReBQ8DeLQ4fUD5cQ@mail.gmail.com>
 <a8e8796e-7266-4c8a-a4eb-31cedf73ec8a@sandisk.com>
Message-ID: <d15c920e-8333-b970-4e8c-4a3fbf148bb4@sandisk.com>

On 09/27/2016 07:42 AM, Bart Van Assche wrote:
> Jens, regarding non-blk-mq mode and q_usage_counter: do you prefer that
> I rework patch 8/9 such that blk_quiesce_queue() and blk_resume_queue()
> are only used in blk-mq mode or are you OK with adding a
> blk_queue_enter() call in get_request() and a blk_queue_exit() call to
> __blk_put_request()?

(replying to my own e-mail)

Although it is easy to make q_usage_counter count non-blk-mq requests, 
extending the blk_quiesce_queue() waiting mechanism to the non-blk-mq 
path is non-trivial. To limit the number of changes in this patch series 
I will drop the non-blk-mq changes from this patch series.

Bart.
