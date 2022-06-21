Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474E6C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsEwsDbITz8DIwPUzrmKlTQteHrWeTPKcZy5vm8xPbQ=; b=aVvFpxrKnu14gct53euIcu6ZE7
	QnrpLXph+eaJg4PG0TyXYOn4Oa7dB6ZG/xS+HGsbYP8avDUvo7kHn7MdEkhI8W+y8xd5TPcq3QQI3
	h6qhg1RejYz8WdF6mns+IJQobEWM94+MXax5Xw5Ic9MmV614j/ccSGyE+sArBOHowf/myn86Ie4y1
	Z/vEALUf38IHvj00mQe4a0UYg0FHp35xDQv4bbDVucwqD5zL8WpPuidOL3DUyAYIaykE4xvLvAFax
	3g49YzGM3yCEURv30RrrvJL+Tq6iSuui01kpHOJ6jzCPGxgBIyeJQ0aE0pIsYBriSr5WQsPuKZJWT
	fRMfeJfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3jHo-006nJM-4W; Tue, 21 Jun 2022 19:11:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3jHl-006nIa-EU
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 19:11:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C39A761722;
	Tue, 21 Jun 2022 19:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A891BC3411C;
	Tue, 21 Jun 2022 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655838696;
	bh=8bxaF9lwh/m77rmXPv/vfdiYX+H8ed+io7y+d2q+Vak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0T5C/20JN1CXjCYwlLdlS1rmFeOstx1y1kHiOY0emAlrF9ogV4dy+Fthat3P/YXM
	 q8rLiYN3yy6IzOf83WrviJvOk/o1XAz+MOqLQ3YuuRMLzmJMQf+T3tsabaBW41vAwZ
	 /0hoWGVhwqi5uBOwDzXq22wOuFGL2IzmM2yf55GVRddcD3btf7mqYpnnK0T7Bf1H6L
	 znuJHh5mMgdL/WXC2YUWj2EP+4AV7JzZ5tEq87R5jjCWHXpB1aLJjOgQtn2lZ6/zuM
	 ua/ynj3qrSPfijoZoy1x1hm4ZPqIZsJ9xiNP/9jjvVa/5DemrlN9GPHeGcerQ5DuU3
	 Rcix0UC8Nrp0Q==
Date: Tue, 21 Jun 2022 13:11:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YrIX5Q5xODHMC5AT@kbusch-mbp.dhcp.thefacebook.com>
References: <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <20220609035323.GA31248@lst.de>
 <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
 <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com>
 <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com>
 <20220617090100.GA7767@lst.de>
 <572E6BCA-2B80-46BB-9FBE-F6AA3D7C8FAC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572E6BCA-2B80-46BB-9FBE-F6AA3D7C8FAC@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_121137_603198_F3DDCD65 
X-CRM114-Status: GOOD (  18.86  )
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

On Tue, Jun 21, 2022 at 06:40:49PM +0000, Alan Adamson wrote:
> +static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	void *data;
> +	struct nvme_ns_id_desc *cur;
> +	u16 status = NVME_SC_SUCCESS;
> +	u8 csi;
> +	int pos, len;
> +	bool csi_seen;
> +
> +	if (!ctrl->subsys->clear_ids)
> +		return status;
> +
> +	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
> +	if (!data)
> +		return NVME_SC_INTERNAL;
> +
> +	status = nvmet_copy_from_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> +	if (status)
> +		goto out_free;
> +
> +	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
> +		cur = data + pos;
> +
> +		if (cur->nidl == 0)
> +			break;
> +		len = cur->nidl;
> +		if (cur->nidt == NVME_NIDT_CSI) {
> +			memcpy(&csi, data + pos + sizeof(struct nvme_ns_id_desc), NVME_NIDT_CSI_LEN);
> +			csi_seen = 1;
> +			break;
> +		}
> +		len += sizeof(struct nvme_ns_id_desc);
> +	}
> +	if (csi_seen) {
> +		cur = data;
> +		cur->nidt = NVME_NIDT_CSI;
> +		cur->nidl = NVME_NIDT_CSI_LEN;
> +		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN);
> +
> +		cur = data + sizeof(struct nvme_ns_id_desc) + NVME_NIDT_CSI_LEN;
> +		cur->nidt = 0;
> +		cur->nidl = 0;
> +		status = nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> +	}

This is clearing the other descriptors only if the controller also reports a
CSI field. I think just do something like the following on top of your patch,
and should be good to go.

---
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index f863cd459652..f9599b0cd129 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -54,17 +54,15 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
 		}
 		len += sizeof(struct nvme_ns_id_desc);
 	}
+
+	memset(data, 0, NVME_IDENTIFY_DATA_SIZE);
 	if (csi_seen) {
 		cur = data;
 		cur->nidt = NVME_NIDT_CSI;
 		cur->nidl = NVME_NIDT_CSI_LEN;
 		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN);
-
-		cur = data + sizeof(struct nvme_ns_id_desc) + NVME_NIDT_CSI_LEN;
-		cur->nidt = 0;
-		cur->nidl = 0;
-		status = nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
 	}
+	status = nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
 out_free:
 	kfree(data);
 	return status;
--

