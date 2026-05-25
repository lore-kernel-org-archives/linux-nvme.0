Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1461FCD5BC9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8t7kLbAK9p7SxyrSTzXXj82MYs+abLkLgms996DrS8=; b=iSa5qxj/X2Nuc7vPbMcs6YRWcP
	UGE8zjsceWAZ+e2S1zv5LKpyNwjh04CIRFCCxNpEoA71LY4DsXh5KFckoM8gzroU2ZBrKMQAvPNAe
	OUh0Mkwu8Msg1f9jmpiOIm+NKVVBqng05Og/VsNE7eFHcBbZlH7/Mntx3xHJf57ng/8pcpJ1hSeLY
	cOTxS63iSvr5L3ntrY6CSKLT163bxWzsZ7vgVdwMD8bY+XT4npAVJ8QKZcRRMh4EobVawE8tR/Uwc
	wEvyr14DTq9bBxvvWDjCKocRILeuziwCAlR6meq2/ZrFK2UcQMHpGu5RVEP5vKIDj8tm9on5MMOhB
	WxR60Ncg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXJi-0000000HXBJ-2gM5;
	Mon, 25 May 2026 15:34:10 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXJf-0000000HXAg-3ZD8
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 15:34:09 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b9e9a6802aso41650765ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 25 May 2026 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723247; x=1780328047; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8t7kLbAK9p7SxyrSTzXXj82MYs+abLkLgms996DrS8=;
        b=oBcXXxlA6NkjlkfRzauyN2PJPe7ZqVIL4IRXmCunGLGkTquIfhj2nXL0VHwZ5DWCc4
         J0Ben5u3aYjQWDpURpLd3whC1nShdTrmJ+yIYADZCSefqdCSL9sB1Hdpr9300h5dIg69
         EbLk3EOUK+UxVzqXojU73mBkDV5GH/mKa705Iudc86v8wSwDpCoiE8YOTOLnIkzRQZ9f
         QFHvD9bw2FNuDgNcDlPvqgeTElGd3NxZfq0cKQuVxVYE7ff3991DNEh7IievCUPqQYtA
         BqTc7nI/uJiD4TH4jnEJEgjJ62xd9nt91WpxGuEn2FnR+V7yfiodc60LpovmB6BSJDCZ
         8XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723247; x=1780328047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8t7kLbAK9p7SxyrSTzXXj82MYs+abLkLgms996DrS8=;
        b=Q+gRRoMTd45YyNivQYoHVEVNjW7g2DFKv8FkByLraGT1u9rm/BlApRVaNP1gZUEYFk
         /DmKTdlPOcXxAuFDtdVEVz76yJyAU1QIXbopxt+Nd5zJg6584SoCgTus/XESjmAJKAX8
         SE7QisBQSYfl7Cbf/TO/hXauJH5WOiEydm6XrRuU4S17a4b6FMDwpKlYSjjWYUwB3P2k
         JTpSI3LX9lM+afAiQd6hJTxPBlfRJsC0eusDA5wbupL0dPpv6AUhhYi5sEaTsNGjveB2
         8uvpcmHQr8zHc4WdO7LCHZkbY419aOHjQGRhey/Lr3b/2Zcol6SXxBu+pUEArPa5qGx+
         pH1g==
X-Forwarded-Encrypted: i=1; AFNElJ9HO2IzTwq7cCcgvgHBaRDHaAk7g3KSMLEJlWg/cz24j1xgbmYsv7PMaZRuQYZIH7ztpacjPr40jB0f@lists.infradead.org
X-Gm-Message-State: AOJu0YzF6I1hBc50reV3UQ5i0u2UgkQRsKRRD58YsJhZcui5Z93xoeFp
	BM7sectJx8HT0jDjOFx1bYXbg7U2kNZXqihLWf8LiY7cCEjzLTcw9u1E
X-Gm-Gg: Acq92OHZMPsBrY6BIf43NNoJthodntqVSeLKoDBTaVuMp6iiiJ1XAjlQDzFaBvKkQBI
	9tARC1pxIR/SM/Y7WSZVRKLlKWfd+Jo/IFxWxXwuPVaCn6rNu9EDExPre4QmIa/Cfrg2ljq5Sgf
	NdBnAcHMRoF6cDmwBo/NOzBxPQBZackR4/F/mvKqtDftceYcQm5y3MrfyKUi3/Y5INQsNwLbRCI
	CIVJWY75rAk9x7pJ54tJOfaLrcwN8YCO36bBiXlKDYyPabRQU2TSA1ZnIG9Yvgq15wl4wklkhr9
	1E7ZVY9jdoZ5pFV6uc349TBGSf2m9nJKBHArQFbAhdQrOQW4BZFv8YD9nbgeVkmS+RXDKHjkIwq
	6wuS167jv4NKFz6NmjB8zTXI7R4yP5vpbznF9NkGh+1HBsbB5U21/yKj/U+C1nswa1cO0hm4xag
	Is03LuRFuEJbMa4tPxfjdQ8Cm/mMJtJMAJMnsL7HBcqIiInhB8UA4F8uCnD3iLD/gXH0qr
X-Received: by 2002:a17:903:1a70:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2beb06bf9d7mr162432535ad.38.1779723246644;
        Mon, 25 May 2026 08:34:06 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:34c9:7e9c:7c33:58d6? ([240b:10:2720:5500:34c9:7e9c:7c33:58d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm102466845ad.10.2026.05.25.08.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 08:34:05 -0700 (PDT)
Message-ID: <cda74a96-cff1-402a-bcdb-745c85f6c87b@gmail.com>
Date: Tue, 26 May 2026 00:34:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set
 Features
To: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Jens Axboe <axboe@kernel.dk>, Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
 Maurizio Lombardi <mlombard@arkamax.eu>, linux-kernel@vger.kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
 Weidong Zhu <weizhu@fiu.edu>
References: <20260523225629.3964037-1-coshi036@gmail.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <20260523225629.3964037-1-coshi036@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_083407_897600_D2A5F8B3 
X-CRM114-Status: GOOD (  29.59  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2026/05/24 7:56, Chao Shi wrote:
> Since commit b58da2d270db ("nvme: update keep alive interval when kato
> is modified"), userspace can start keep-alive on any transport via a
> Set Features (KATO) passthrough command. nvme_keep_alive_work() then
> allocates with BLK_MQ_REQ_RESERVED, but nvme_alloc_admin_tag_set()
> only reserves admin tags for fabrics, so the allocation trips
> WARN_ON_ONCE() in blk_mq_get_tag() and fails:
>
>    nvme nvme0: keep-alive failed: -11
>
> More generally, several Set Features change controller state that the
> driver manages itself and cannot react to correctly when set behind
> its back from userspace. Reject these in nvme_cmd_allowed():
>
>    - KATO on non-fabrics (keep-alive is only armed for fabrics; on PCIe
>      it has no reserved tag and an active keep-alive harms idle power
>      states)
>    - Host Behavior Support, Host Memory Buffer, Number of Queues, and
>      Autonomous Power State Transition (all driver-managed)
>
> Keep Alive on fabrics is unchanged. I/O commands are unaffected as the
> check is confined to the admin path (ns == NULL).
>
> Link: https://lore.kernel.org/linux-nvme/20260522162639.395802-1-coshi036@gmail.com/
>
> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
>
> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
>
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
>
> Reproducer for the keep-alive case (run as root on a PCIe NVMe device):
>
>      #include <fcntl.h>
>      #include <stdio.h>
>      #include <string.h>
>      #include <sys/ioctl.h>
>      #include <linux/nvme_ioctl.h>
>
>      int main(void)
>      {
>              struct nvme_admin_cmd cmd = {0};
>              int fd = open("/dev/nvme0", O_RDWR);
>              if (fd < 0) { perror("open"); return 1; }
>              cmd.opcode = 0x09;       /* SET_FEATURES */
>              cmd.cdw10  = 0x0f;       /* Feature ID: KATO */
>              cmd.cdw11  = 5;          /* KATO = 5 seconds */
>              if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd) < 0) {
>                      perror("ioctl");
>                      return 1;
>              }
>              return 0;
>      }
>
> On an unpatched kernel, within ~kato/2 seconds after the program exits,
> dmesg shows:
>
>      nvme nvme0: keep alive interval updated from 0 ms to 5000 ms
>      WARNING: CPU: 0 PID: ... at block/blk-mq-tag.c:148 blk_mq_get_tag+...
>      nvme nvme0: keep-alive failed: -11
>
> With this patch the ioctl fails with EACCES on non-fabrics.
>
> Changes since v4:
> - Fold the check into the existing nvme_cmd_allowed() instead of a
>    separate helper, and reject additional driver-managed Set Features
>    (Host Behavior, Host Memory Buffer, Number of Queues, Autonomous
>    Power State Transition) in the same switch (Keith Busch). The admin
>    vs I/O distinction is now structural: the switch lives in the
>    ns == NULL branch, so I/O commands (e.g. Dataset Management, which
>    shares opcode 0x09 with Set Features) are never inspected.
>
> Changes since v3:
> - Only inspect admin commands so a DSM I/O command is not wrongly
>    rejected (Keith Busch).
>
> Changes since v2:
> - Reject the KATO passthrough on non-fabrics instead of reserving an
>    admin tag for all transports (Keith Busch, Christoph Hellwig).
>
> Changes since v1:
> - v2 added a spec citation and quirk discussion, superseded by the
>    reject approach.
>
>   drivers/nvme/host/ioctl.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a9c097dacad6..31784506e845 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -14,8 +14,9 @@ enum {
>   	NVME_IOCTL_PARTITION	= (1 << 1),
>   };
>   
> -static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> -		unsigned int flags, bool open_for_write)
> +static bool nvme_cmd_allowed(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			     struct nvme_command *c, unsigned int flags,
> +			     bool open_for_write)

The struct nvme_ns does already have the struct nvme_ctrl *ctrl as a 
member variable as below so seems not necessary to add the function 
argument struct nvme_ctrl *ctrl.
struct nvme_ns {

     struct list_head list;

     struct nvme_ctrl *ctrl;


