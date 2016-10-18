From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 14:56:04 -0700
Subject: [PATCH v3 0/11] Fix race conditions related to stopping block
 layer queues
In-Reply-To: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
Message-ID: <8fa81aa5-746f-c163-e26b-3a7becf7259e@sandisk.com>

On 10/18/2016 02:48 PM, Bart Van Assche wrote:
> - blk_mq_quiesce_queue() has been reworked (thanks to Ming Lin and Sagi
>    for their feedback).

(replying to my own e-mail)

A correction: Ming Lei provided feedback on v2 of this patch series 
instead of Ming Lin.

Bart.
