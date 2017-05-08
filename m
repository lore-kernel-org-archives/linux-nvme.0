From: jsmart2021@gmail.com (James Smart)
Date: Mon, 8 May 2017 09:35:11 -0700
Subject: [PATCH] nvme_fc: set logging level on resets/deletes
In-Reply-To: <552d0a62-d74d-f20b-049f-11338b701c5f@suse.de>
References: <20170425223234.3958-1-jsmart2021@gmail.com>
 <552d0a62-d74d-f20b-049f-11338b701c5f@suse.de>
Message-ID: <58f12888-7c66-88e2-5a31-3dbb3f3b886d@gmail.com>

On 5/8/2017 2:31 AM, Johannes Thumshirn wrote:
> Can you maybe change the above two messages to dev_debug()? I have a gut
> feeling that they might become handy one day.

After debugging things, I didn't find these providing anything of value, 
thus their deletion. The debug message of the connecting-to subnqn is 
more than enough to derive this (e.g. is it the discovery nqn or not; as 
only discovery ctrl would not attempt io queues), and additional actions 
on the link, as well as messages by the target as it creates queues was 
enough.

-- james
