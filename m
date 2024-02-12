Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DE3C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccUj65vFwVwpZbvARsSl1ghILoPeMaHnEggRWAiCcdc=; b=CeZlTlbyACrqiTd/fv/dTYj6jS
	cUoyVgabQdivO4dRDHT8u3hu+wPSz1C8cWJvjJymfeCCvCIQRtorVx1GjLUeBgHeSBEFa6NzOndIN
	rnnHdhKcwFGTO48se9T1PnHbV/9tMx3l9fn4a8aEzfNShlbhE9C7BDGzCfO5LXLkSZFbIPRx43oMc
	VaJDs80X81CTTPYNllnWrnDobb7XXgHmarpNeS0nHa/UfwEXpfcIvZ72OxAQIxulPJvQ1QFX3b1Lz
	eQxLiF8iMUE7JvnR1tx93lzwlJGOQNDxV1HcRuXrRbqlYKDoo4eBA11wqoukbJapPy79911AADwUS
	pwYreiJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQfN-00000004UkN-3knz;
	Mon, 12 Feb 2024 07:23:49 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQfI-00000004Ujj-3CRU
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:23:48 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240212072338epoutp01639fb12ccc0be2db3e9b489ee2a3e1ce~zDKyDxbXO1740217402epoutp01Q
	for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 07:23:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240212072338epoutp01639fb12ccc0be2db3e9b489ee2a3e1ce~zDKyDxbXO1740217402epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707722618;
	bh=ccUj65vFwVwpZbvARsSl1ghILoPeMaHnEggRWAiCcdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EexqBvlF/JJUhufxhrEZEtfo2vsraMSq1azGEL3CSXMp99VYlQYOMbKQg5KG99Vdd
	 CN3kjVSy7jNdSG+PStot1yrBv3JlZEs93NjWayHLsiLOQzKxaTTXY3/kLItSWxEpor
	 DjqoveaT1xV/eSCz8G2ls6c/f1hXCxjMs24njSig=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240212072338epcas5p374c5ada21fd4a1b761e4f4a8475671be~zDKxw8vpa2338123381epcas5p3B;
	Mon, 12 Feb 2024 07:23:38 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TYGCY2YTNz4x9Q0; Mon, 12 Feb
	2024 07:23:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.DD.19369.977C9C56; Mon, 12 Feb 2024 16:23:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240212070024epcas5p15af7a6b038a30b3918adc517641b8eb1~zC2fODusj2540725407epcas5p1B;
	Mon, 12 Feb 2024 07:00:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240212070024epsmtrp166ac5490cef9cbb39187a699f44a33e5~zC2fNd13h2267122671epsmtrp1W;
	Mon, 12 Feb 2024 07:00:24 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-b9-65c9c7794ef6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.0D.08755.802C9C56; Mon, 12 Feb 2024 16:00:24 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240212070023epsmtip18e9d3d864647a64df0f7dd2dbaa50b5e~zC2eWfBBz1621516215epsmtip1e;
	Mon, 12 Feb 2024 07:00:23 +0000 (GMT)
Date: Mon, 12 Feb 2024 12:23:43 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Message-ID: <20240212065343.mddx6u7gzzkx3i7e@green245>
MIME-Version: 1.0
In-Reply-To: <20240212042641.227821-1-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmhm7l8ZOpBkeWCVmsXH2UyWLSoWuM
	Fk+vzmKymL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/Ywtgjcq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzrjb9Y254KB0
	Rev8FtYGxnXiXYycHBICJhLPTv9h6mLk4hAS2MMo0XdsFwuE84lRYuv/I1DON0aJPUfPMMG0
	rGvczwaR2Mso0ftiJTuE84xR4kbvDEaQKhYBVYkd81qB2jk42AS0JU7/5wAJiwioS0w90MMK
	YjMLhEp8vrAarFxYwEtiysxuZhCbV8BMYu2ibywQtqDEyZlPwGxOAVOJp4s/sIPYogIyEjOW
	fmUG2Ssh8JFd4uOW34wQ17lI7LnXyAJhC0u8Or6FHcKWknjZ3wZll0usnLKCDaK5hVFi1vVZ
	UM32Eq2n+pkhrsuQmH1vLVRcVmLqqXVMEHE+id7fT6BBwQv0JIytLLFm/QI2CFtS4tr3Rijb
	Q2LlquPMkBDqYJRYeeoA4wRG+VlIvpuFZB+EbSXR+aGJdRYw8JgFpCWW/+OAMDUl1u/SX8DI
	uopRKrWgODc9Ndm0wFA3L7UcHufJ+bmbGMHJUytgB+PqDX/1DjEycTAeYpTgYFYS4b0040Sq
	EG9KYmVValF+fFFpTmrxIUZTYGxNZJYSTc4Hpu+8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE
	0hNLUrNTUwtSi2D6mDg4pRqY4u0nuP248DNflJWxkGfWfs+Y1vCZN79ttKkJqzMWX6c967nW
	Fpb/lu9NPXp6n+49bHdhmWTYmrq7nbu+/X5QwnVrg9bMHgH+Qt6Shjy+lXOmfrjJKRxflvzv
	5EojBT8j1Rj531/8m/lX7DadfSpsgcLKvfoBfjNtrp0x2CTJ9/WCnJj3Br4iO1GeNm5eI9PG
	h55z72+6t7nyaOiNDSunB/os29mkz6h7QV3kQMt2cf9Xc5+p8q56ZG71bbXjFcO1K/q3bE60
	5prRe35Xzu2XL5q1ZHNjI+56flO293hqzqyxeR07U66Xuv+yDe5KDAqJ834cLNpwcGtY/duu
	o5rs1tsFg/Obl9RYfruTUC2kxFKckWioxVxUnAgAcNQKXycEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnC7HoZOpBtP/MlusXH2UyWLSoWuM
	Fk+vzmKymL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DKOLbsBVPBZ4mKy9f5Ghh/iXQxcnJICJhIrGvcz9bFyMUhJLCbUeLF0ofsEAlJiWV/
	jzBD2MISK/89Z4coesIocb/vGytIgkVAVWLHvFaWLkYODjYBbYnT/zlAwiIC6hJTD/SAlTAL
	hEp8vrCaEcQWFvCSmDKzG2wmr4CZxNpF31hAbCGgI87NX8MCEReUODnzCQtEr5nEvM0PmUHG
	MwtISyz/BzaeU8BU4uniD2BnigrISMxY+pV5AqPgLCTds5B0z0LoXsDIvIpRMrWgODc9t9iw
	wDAvtVyvODG3uDQvXS85P3cTIzjUtTR3MG5f9UHvECMTB+MhRgkOZiUR3kszTqQK8aYkVlal
	FuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYJqv7MV8VejossPHba04
	d5Z+XfHQLYy/8cS1kxuv7rt+c8mXf0J+N7Q3r7V+kBgatm9vT6rsVzNBq4oMC0P157rxatfs
	FmX4N/Tvq9p9LPptpIoi3yG/CP7vSS38ic/f/OeQvdLw7cB0Zcvo5V/UZf3rO1/WFGktCxFU
	c36rUTfF8cTTbwl/oz/0/Ur45PZ0I6uP0bS+2uqpvCrt2zKPB054OGNizpMMVcmVc92cr8hu
	d3jZzDXjw9pLIkoHH89cv+KqQ53Nqgk1O76/ETHplKyU9BabmTvH0snYeHo12yIdVe79k3Xa
	plm35Syr3CSxYmWklKpbY5HtinXFvWLnvT/KfJ/kxbbxwwadvVVvDyuxFGckGmoxFxUnAgCw
	bVFp5AIAAA==
X-CMS-MailID: 20240212070024epcas5p15af7a6b038a30b3918adc517641b8eb1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----pu6SM7VbJyTRWgxKLeCSNf3.iFRjJ005v6-egSs_piPkym2g=_4acaa_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240212070024epcas5p15af7a6b038a30b3918adc517641b8eb1
References: <20240212042641.227821-1-kch@nvidia.com>
	<CGME20240212070024epcas5p15af7a6b038a30b3918adc517641b8eb1@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232346_272612_005B6B96 
X-CRM114-Status: GOOD (  17.95  )
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

------pu6SM7VbJyTRWgxKLeCSNf3.iFRjJ005v6-egSs_piPkym2g=_4acaa_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 11/02/24 08:26PM, Chaitanya Kulkarni wrote:
>NVMe controller state machine has total 7 states and 13 state transition
>arcs. Debugging NVMeOF problems in the field is not straight-froward,
>since it involves complex combination of connect/reconnect/kato/timeout
>handlers etc scenarios.
>We already have a helper in sysfs.c that reads the controller state, but
>one has to constantly read the state in order understand the complete
>state transition which is very inconvenient.
>
>It is often helpful to know full state transition of controller when
>dealing with NVMeOF issues at the time of analyzing the trace.
>
>Add a helper that allows us to decode and print each controller state
>transition :-
>
>blktests (master) # dmesg -c | grep nvme_change_ctrl_state
>blktests (master) # nvme_trtype=tcp ./check nvme/048
>nvme/048 (Test queue count changes on reconnect)             [passed]
>    runtime  6.264s  ...  5.240s
>blktests (master) # dmesg -c | grep nvme_change_ctrl_state
>[17080.988689] nvme nvme0: nvme_change_ctrl_state new -> connecting
>[17081.006623] nvme nvme0: nvme_change_ctrl_state connecting -> live
>[17081.038313] nvme nvme0: nvme_change_ctrl_state live -> resetting
>[17081.040730] nvme nvme0: nvme_change_ctrl_state resetting -> connecting
>[17083.056750] nvme nvme0: nvme_change_ctrl_state connecting -> live
>[17083.075906] nvme nvme0: nvme_change_ctrl_state live -> resetting
>[17083.076112] nvme nvme0: nvme_change_ctrl_state resetting -> connecting
>[17085.105270] nvme nvme0: nvme_change_ctrl_state connecting -> live
>[17086.126484] nvme nvme0: nvme_change_ctrl_state live -> deleting
>[17086.126506] nvme nvme0: nvme_change_ctrl_state deleting -> deleting (no IO)
>blktests (master) #
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
>
> drivers/nvme/host/core.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index 20c0c141fcc0..daeb2409f989 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -544,6 +544,21 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> }
> EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>
>+static const char *nvme_ctrl_state_str(enum nvme_ctrl_state st)
>+{
>+	static const char *const str[] = {
>+		[NVME_CTRL_NEW]			= "new",
>+		[NVME_CTRL_LIVE]		= "live",
>+		[NVME_CTRL_RESETTING]		= "resetting",
>+		[NVME_CTRL_CONNECTING]		= "connecting",
>+		[NVME_CTRL_DELETING]		= "deleting",
>+		[NVME_CTRL_DELETING_NOIO]	= "deleting (no IO)",
>+		[NVME_CTRL_DEAD]		= "dead",
>+	};
>+
>+	return st < ARRAY_SIZE(str) && str[st] ? str[st] : "unknown state";
>+}
>+
> bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> 		enum nvme_ctrl_state new_state)
> {
>@@ -621,6 +636,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
> 	}
>
> 	if (changed) {
>+		dev_dbg(ctrl->device, "%s %s -> %s\n", __func__,
>+			nvme_ctrl_state_str(old_state),
>+			nvme_ctrl_state_str(new_state));
> 		WRITE_ONCE(ctrl->state, new_state);
> 		wake_up_all(&ctrl->state_wq);
> 	}
>-- 
>2.40.0
>
>

Revieved-by: Nitesh Shetty <nj.shetty@samsung.com>

------pu6SM7VbJyTRWgxKLeCSNf3.iFRjJ005v6-egSs_piPkym2g=_4acaa_
Content-Type: text/plain; charset="utf-8"


------pu6SM7VbJyTRWgxKLeCSNf3.iFRjJ005v6-egSs_piPkym2g=_4acaa_--

