From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 2 Nov 2016 13:35:40 -0600
Subject: [PATCH v5 0/14] Fix race conditions related to stopping block
 layer queues
In-Reply-To: <cfd115a1-78e1-7ed5-3c19-42334a5dbe72@fb.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <cfd115a1-78e1-7ed5-3c19-42334a5dbe72@fb.com>
Message-ID: <cb120a20-2a40-053a-5621-2209777b5ef4@sandisk.com>

On 11/02/2016 01:08 PM, Jens Axboe wrote:
> Bart, I have applied the series, except patches 11+12. I don't mind
> taking them through the block tree, but they can go through the SCSI
> tree as well. Let me know what folks think.

Hello Jens,

Thanks for having applied this patch series. I will resend the SCSI 
patches to the SCSI maintainers. Since I am not aware of any bug report 
for which these patches are the proper fix I don't think there is any 
urgency to apply the SCSI patches.

Bart.
