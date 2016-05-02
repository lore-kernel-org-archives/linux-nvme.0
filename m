From: axboe@fb.com (Jens Axboe)
Date: Mon, 2 May 2016 09:13:45 -0600
Subject: [PATCH] NVMe: correct comment for offset enum of controller
 registers in nvme.h
In-Reply-To: <1461759016-7829-1-git-send-email-shhuiw@foxmail.com>
References: <1461759016-7829-1-git-send-email-shhuiw@foxmail.com>
Message-ID: <57276EA9.3060702@fb.com>

On 04/27/2016 06:10 AM, Wang Sheng-Hui wrote:
> Section 3.1 gives the comment for the offset of controller registers
> in the specification 1.2a.
>
> Some are mis-copied in the header file nvme.h. Correct them.

Added to 4.7.

-- 
Jens Axboe
