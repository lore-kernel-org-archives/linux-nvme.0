Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F9C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luc+FpHHcic6qu8cy7Eivhe9UaeinVCeCHd7pHmvqko=; b=Olx04cm2fR1raYXJDXEkKYprHc
	dfeEQoABne7mTZfqyA7JyDfJZ5a12rsUNPIO8kLQiDV7yVwJe4xkmDG/3PU0Qb7nRmQDIEOVJ/JAC
	Ky7js+FvxGnOLIyPgJeAQZTf28vpcIsHAt7b9FRJM8TDcV4FubD4VUbudaZPZtUbLq/JqdbgH2JWA
	u4E6m8sId6qJyQMTlOYt3B9htOboS6HPwNnGFD25zknitwvlQxtEpSlNNmwx4zyg6Vy3OOe6d1AjA
	I9yZ2q2ccXxWqDeJP9iSAsO9GfDjmoe86d1LRxna7SYHR/BpvRLArusq/buiEuk7VrELseIvHbEeG
	dPezv3LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQfT-00000004UlV-29CE;
	Mon, 12 Feb 2024 07:23:55 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQfP-00000004Uk8-17E8
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:23:54 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240212072344epoutp04ad5d3f7fd0abd2acaac63df35323dafa~zDK3ZDDHc2324323243epoutp04G
	for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 07:23:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240212072344epoutp04ad5d3f7fd0abd2acaac63df35323dafa~zDK3ZDDHc2324323243epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707722624;
	bh=luc+FpHHcic6qu8cy7Eivhe9UaeinVCeCHd7pHmvqko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfUqvsAvGs2DK5lo11sBmtLo9EoBgHSucLR4qNWNyUMfwyp3QKjtF0D0KL/d74jXX
	 om7hgQuu36q0OaGGTM5pvRaYJxd7Vpt36mOLS2tNM6z0sgfbcMhr7XXTSEEX/x+vF1
	 s9Vkk1FLig7N6Tfxwtg1XM2jgtOeWM7R6uC3qMRc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240212072343epcas5p2fd0dd1b160065c5c8ad5a032d2d5410b~zDK2TY7NX0127001270epcas5p2v;
	Mon, 12 Feb 2024 07:23:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TYGCf19JSz4x9Py; Mon, 12 Feb
	2024 07:23:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.F2.10009.D77C9C56; Mon, 12 Feb 2024 16:23:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240212070101epcas5p494f315c1960886e1fae74040ed215154~zC3BoswML1708717087epcas5p45;
	Mon, 12 Feb 2024 07:01:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240212070101epsmtrp25edac410700858dd7c000282854cc144~zC3BoFzPY2630626306epsmtrp2g;
	Mon, 12 Feb 2024 07:01:01 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-f2-65c9c77de831
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	74.85.18939.C22C9C56; Mon, 12 Feb 2024 16:01:01 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240212070100epsmtip283f972e6c8a1001abb32fc4fae7bcc9b~zC3Axyl532566225662epsmtip2u;
	Mon, 12 Feb 2024 07:01:00 +0000 (GMT)
Date: Mon, 12 Feb 2024 12:24:25 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme: export and use previously added helper
Message-ID: <20240212065425.pe7xxk42cqmkkvgr@green245>
MIME-Version: 1.0
In-Reply-To: <20240212042641.227821-2-kch@nvidia.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmpm7d8ZOpBt2/mSxWrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRmXbZKQmpqQW
	KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
	K+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZzy7cZqx4LdY
	xfNr59gbGN8IdzFyckgImEjMnbmduYuRi0NIYDejxPfN95kgnE+MEheOT0Rw/myezdLFyAHW
	8meaDkR8J6PEqwtTWSGcZ4wSfY3HWUHmsgioStxeP58dpIFNQFvi9H8OkLCIgLrE1AM9YCXM
	AqESny+sZgSxhQVcJSafbgCzeQXMJDbduA1lC0qcnPmEBcTmFDCVOLtnCxuILSogIzFj6Vdm
	iBdesktcv6kGYbtI7L+xhxXCFpZ4dXwLO4QtJfH53V42CLtcYuWUFWwgN0sItDBKzLo+ixEi
	YS/ReqqfGeK4DIkjX59CNctKTD21jgkizifR+/sJE0ScV2LHPBhbWWLN+gVQCyQlrn1vhLI9
	JPa3zwKzhQQ2M0ps3ic3gVF+FpLfZiFZB2FbSXR+aGKdBQw6ZgFpieX/OCBMTYn1u/QXMLKu
	YpRMLSjOTU8tNi0wyksth8d3cn7uJkZw0tTy2sH48MEHvUOMTByMhxglOJiVRHgvzTiRKsSb
	klhZlVqUH19UmpNafIjRFBhVE5mlRJPzgWk7ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTE
	ktTs1NSC1CKYPiYOTqkGJsbgo33Tv3UFnwyYqBTCdrLP5zLfBY+JZ5YtWpCi0Rc1Paj5n0Zt
	kRzf9hf3X5jmuEx99YZrItf74nWXMhYl1OgJdk2pSLsz3+Ee19ssBtZDU+Rcvsyc+aGg6Yz2
	9ztruJmOLDigPq9Bfdqs048cnLhaWb9d93O3n/Do2db7bm6relf3Hr/u3CUd8uLs5Utbglcn
	HdrusctMsrzo+5Jig65fjzo2pXAmn2IMPcB/QsAz0cN+8gHNo4n87yPlYp173A482ZTsHpYX
	Iqsfx3lXeGrc/qepoQuTE6auC38qVz0/NUnznNDmo99V3npdu83x8dLWm5X2rBtOdSyatFz9
	mdjjd6wuztvuti28pl+oz63EUpyRaKjFXFScCAB0cgvmIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvK7uoZOpBrsPMlmsXH2UyWLSoWuM
	Fk+vzmKymL/sKbvFutfvWRxYPc7f28jisWlVJ5vH5iX1HrtvNrB59Da/YwtgjeKySUnNySxL
	LdK3S+DK2Lh0A1vBWpGK/ve7WBsYdwh2MXJwSAiYSPyZptPFyMUhJLCdUeLz43VsXYycQHFJ
	iWV/jzBD2MISK/89Z4coesIoceDBT0aQBIuAqsTt9fPZQQaxCWhLnP7PARIWEVCXmHqghxXE
	ZhYIlfh8YTVYubCAq8Tk0w1gNq+AmcSmG7fBbCGBeInWP5eh4oISJ2c+YYHoNZOYt/khM8h4
	ZgFpieX/wMZzCphKnN2zBexMUQEZiRlLvzJPYBSchaR7FpLuWQjdCxiZVzGKphYU56bnJhcY
	6hUn5haX5qXrJefnbmIEh7hW0A7GZev/6h1iZOJgPMQowcGsJMJ7acaJVCHelMTKqtSi/Pii
	0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQamstiYU7PYt4i92ePSaiByr8sm
	osj+cEil19PX919faeNdZv0sMKqo/YRwR36Sm3h81hKfMKtrN6siy39Ubzf/3vTorsfyk982
	XnnXl8fbZOagcGnNspt/dqxd/sdCYOk+Pf2dsS/v1f4+89Pn/0E29hVFVko3zr0+ctJh402B
	yMgpMtOZ0o5rCX+WTS6deMjWztltx7XFMdq/v9ZVa9RMi3lRYOgeufgu/xGDPPe5O8UWKp99
	/JLV+0vSVftLh+fouAZv27L0eRWz1lrPeY9/VggfOTShx3oNR/LyxaceXGB9/+3bVjaBT2fm
	fe36m+zzMJPDT5tpjZbjnHgfvjzJb9uPxOhcXyV38e77s98Sc5VYijMSDbWYi4oTAd2csHbg
	AgAA
X-CMS-MailID: 20240212070101epcas5p494f315c1960886e1fae74040ed215154
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----OO6PTBVLx8MaV.Rvw7Ow5IblUrGHELXpy2cqE688gWl8V9Go=_4aee3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240212070101epcas5p494f315c1960886e1fae74040ed215154
References: <20240212042641.227821-1-kch@nvidia.com>
	<20240212042641.227821-2-kch@nvidia.com>
	<CGME20240212070101epcas5p494f315c1960886e1fae74040ed215154@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232351_643359_9139096D 
X-CRM114-Status: GOOD (  14.82  )
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

------OO6PTBVLx8MaV.Rvw7Ow5IblUrGHELXpy2cqE688gWl8V9Go=_4aee3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 11/02/24 08:26PM, Chaitanya Kulkarni wrote:
>Export nvme_ctrl_state_str() and use it in the host/sysfs.c:
>nvme_sysfs_show_state().
>
>Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>---
> drivers/nvme/host/core.c  |  2 +-
> drivers/nvme/host/nvme.h  |  1 +
> drivers/nvme/host/sysfs.c | 16 ++--------------
> 3 files changed, 4 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>index daeb2409f989..acde9e377c00 100644
>--- a/drivers/nvme/host/core.c
>+++ b/drivers/nvme/host/core.c
>@@ -544,7 +544,7 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
> }
> EXPORT_SYMBOL_GPL(nvme_cancel_admin_tagset);
>
>-static const char *nvme_ctrl_state_str(enum nvme_ctrl_state st)
>+const char *nvme_ctrl_state_str(enum nvme_ctrl_state st)
> {
> 	static const char *const str[] = {
> 		[NVME_CTRL_NEW]			= "new",
>diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>index 3ca486fe927c..3584c3861d6c 100644
>--- a/drivers/nvme/host/nvme.h
>+++ b/drivers/nvme/host/nvme.h
>@@ -1094,6 +1094,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
> struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
> struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
> void nvme_put_ns(struct nvme_ns *ns);
>+const char *nvme_ctrl_state_str(enum nvme_ctrl_state st);
>
> static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
> {
>diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>index f2832f70e7e0..a067feaba5ae 100644
>--- a/drivers/nvme/host/sysfs.c
>+++ b/drivers/nvme/host/sysfs.c
>@@ -368,21 +368,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
> 				     char *buf)
> {
> 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>-	unsigned state = (unsigned)nvme_ctrl_state(ctrl);
>-	static const char *const state_name[] = {
>-		[NVME_CTRL_NEW]		= "new",
>-		[NVME_CTRL_LIVE]	= "live",
>-		[NVME_CTRL_RESETTING]	= "resetting",
>-		[NVME_CTRL_CONNECTING]	= "connecting",
>-		[NVME_CTRL_DELETING]	= "deleting",
>-		[NVME_CTRL_DELETING_NOIO]= "deleting (no IO)",
>-		[NVME_CTRL_DEAD]	= "dead",
>-	};
>-
>-	if (state < ARRAY_SIZE(state_name) && state_name[state])
>-		return sysfs_emit(buf, "%s\n", state_name[state]);
>
>-	return sysfs_emit(buf, "unknown state\n");
>+	return sysfs_emit(buf, "%s\n",
>+			  nvme_ctrl_state_str(nvme_ctrl_state(ctrl)));
> }
>
> static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
>-- 
>2.40.0
>
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------OO6PTBVLx8MaV.Rvw7Ow5IblUrGHELXpy2cqE688gWl8V9Go=_4aee3_
Content-Type: text/plain; charset="utf-8"


------OO6PTBVLx8MaV.Rvw7Ow5IblUrGHELXpy2cqE688gWl8V9Go=_4aee3_--

