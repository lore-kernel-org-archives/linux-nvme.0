Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EB3D3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Os+S4pHy7trxPWBaGt6FASH6K1G9Xgdn5eNIwNX8SiE=; b=SW7YXJ//VNl0UUS5jPZEnRXrKf
	N2vLd6CrMSTzKUB8+irUY6mbjNeSK9QcvlGw/GgmeDYjnDSnPgUeFSrLvHfcsn3khAdfUJBEDDuL0
	v0CtMacgVtCMUeI0yNq6SjNFAd3dn7DwI2XeM4Dzvo4qadK93pmMeNOxI7kKImgNAqnsvhwo0Jqqg
	BfpEfyRKF0mvNSqhd6NF51hBwoYshLgBBBLTxv73ZUAsGOu6DF1Gm5dK60DX3CP53/CmFU7bxtA2d
	Z5hrG/ionr4W1eQ/VzVNNoERr1lSFne0ONRMfC0msJpKUeA8jQMWZVaBQHTKVcWLvACxiSfEvo5Yd
	g8TBymog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qPn-0000000FOhi-0IBr;
	Tue, 29 Oct 2024 17:53:59 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5prn-0000000FE8T-43C4
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:18:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XdH682yjwzlgMVd;
	Tue, 29 Oct 2024 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730222315; x=1732814316; bh=Os+S4pHy7trxPWBaGt6FASH6
	K1G9Xgdn5eNIwNX8SiE=; b=Lxs/REA4wylfESXkATPL24Gb7eQfk4klgZJ/W5Zu
	g+KzwFz9gVBXOtBtfqFAiZ+hZUAcRkkKrssAcminMzwVZ61rhk8fpZEDtyf4IToe
	Wj7Uh+Qua9StMJ+JUx7I/A7lwfpQ7NkhDKIOtB22OgNR15iavT4EcLifRvXtR6ZP
	Z+W5dtY20asvPZMxFuDTcs5+8L5r6LptxN6IX08H4j2L5r08jI2WImkyV2garTV/
	4m+oKY6OzZQFfMulGQfKErmZrMJ+MW/lu28Yr10FOi8l2jqoeyKBtz2cTuFdwRUk
	xsdn+hWJbpaZ1FOKEru9zO9fSrbZaJ/hgskRh11QpEg9qQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sPa9noDahnIv; Tue, 29 Oct 2024 17:18:35 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XdH606Yv3zlgMVY;
	Tue, 29 Oct 2024 17:18:32 +0000 (UTC)
Message-ID: <343c29f2-59d6-48c5-937f-a02775b192ae@acm.org>
Date: Tue, 29 Oct 2024 10:18:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, javier.gonz@samsung.com,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241029152654.GC26431@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_101852_026916_2EFF2EBA 
X-CRM114-Status: GOOD (  17.36  )
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

On 10/29/24 8:26 AM, Christoph Hellwig wrote:
> Bart, btw: I think the current sd implementation is buggy as well, as
> it assumes the permanent streams are ordered by their data temperature
> in the IO Advise hints mode page, but I can't find anything in the
> spec that requires a particular ordering.

How about modifying sd_read_io_hints() such that permanent stream
information is ignored if the order of the RELATIVE LIFETIME information
reported by the GET STREAM STATUS command does not match the permanent
stream order?

Thanks,

Bart.

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 41e2dfa2d67d..277035febd82 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3192,7 +3192,12 @@ sd_read_cache_type(struct scsi_disk *sdkp, 
unsigned char *buffer)
  	sdkp->DPOFUA = 0;
  }

-static bool sd_is_perm_stream(struct scsi_disk *sdkp, unsigned int 
stream_id)
+/*
+ * Returns the relative lifetime of a permanent stream. Returns -1 if the
+ * GET STREAM STATUS command fails or if the stream is not a permanent 
stream.
+ */
+static int sd_perm_stream_rel_lifetime(struct scsi_disk *sdkp,
+				       unsigned int stream_id)
  {
  	u8 cdb[16] = { SERVICE_ACTION_IN_16, SAI_GET_STREAM_STATUS };
  	struct {
@@ -3212,14 +3217,16 @@ static bool sd_is_perm_stream(struct scsi_disk 
*sdkp, unsigned int stream_id)
  	res = scsi_execute_cmd(sdev, cdb, REQ_OP_DRV_IN, &buf, sizeof(buf),
  			       SD_TIMEOUT, sdkp->max_retries, &exec_args);
  	if (res < 0)
-		return false;
+		return -1;
  	if (scsi_status_is_check_condition(res) && scsi_sense_valid(&sshdr))
  		sd_print_sense_hdr(sdkp, &sshdr);
  	if (res)
-		return false;
+		return -1;
  	if (get_unaligned_be32(&buf.h.len) < sizeof(struct scsi_stream_status))
-		return false;
-	return buf.h.stream_status[0].perm;
+		return -1;
+	if (!buf.h.stream_status[0].perm)
+		return -1;
+	return buf.h.stream_status[0].rel_lifetime;
  }

  static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char 
*buffer)
@@ -3247,9 +3254,17 @@ static void sd_read_io_hints(struct scsi_disk 
*sdkp, unsigned char *buffer)
  	 * should assign the lowest numbered stream identifiers to permanent
  	 * streams.
  	 */
-	for (desc = start; desc < end; desc++)
-		if (!desc->st_enble || !sd_is_perm_stream(sdkp, desc - start))
+	int prev_rel_lifetime = -1;
+	for (desc = start; desc < end; desc++) {
+		int rel_lifetime;
+
+		if (!desc->st_enble)
  			break;
+		rel_lifetime = sd_perm_stream_rel_lifetime(sdkp, desc - start);
+		if (rel_lifetime < 0 || rel_lifetime < prev_rel_lifetime)
+			break;
+		prev_rel_lifetime = rel_lifetime;
+	}
  	permanent_stream_count_old = sdkp->permanent_stream_count;
  	sdkp->permanent_stream_count = desc - start;
  	if (sdkp->rscs && sdkp->permanent_stream_count < 2)


