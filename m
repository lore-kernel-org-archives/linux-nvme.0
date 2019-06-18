From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 18 Jun 2019 22:18:54 +0900
Subject: [PATCH v2 4/4] nvme: add support weighted round robin queue
In-Reply-To: <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
 <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
Message-ID: <20190618131854.GA419@minwooim-desktop>

On 19-06-16 18:15:56, Weiping Zhang wrote:
> Now nvme support five types hardware queue:
> poll:		if io was marked for poll
> wrr_low:	weighted round robin low
> wrr_medium:	weighted round robin medium
> wrr_high:	weighted round robin high
> read:		for read, if blkcg's wrr is none and is not poll
> defaut:		for write/flush, if blkcg's wrr is none and is not poll
> 
> for read, default and poll those submission queue's priority is medium by default;
> 
> Signed-off-by: Weiping Zhang <zhangweiping at didiglobal.com>

Hello Weiping,

Please add linux-nvme mailing list for this patch to be reviewed from
the nvme people.
