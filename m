Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4E1CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=; b=r6QX3WJIVU2+KVDBtLxu25wwEr
	RvFjfCR7LD93YjgylUmMTL/sk3XGAWnqY20yCBkwssR+FqkkCPoadQin0E/0c4mnivtU4HdGgxt0m
	MbDwYxKwgukin1I+T+HYo8OPqc4/Kpa33gyEKge4AvCcTl3oif9dikbX9vEKDFdpiuhfzCegGZrsM
	o1Usi2VPwn5TtMBBmhlJiUwqK3HJpOu5WqyZs6jy2Ay9nDSwik8t+KSAd9AymiZqR3DPl0bCFcxx9
	jScyjmSj9VotL76N2IsdXL5aAdjDHkt4hh5Il0bXuunY1wy6mHAWn+tmX0fFGDS0+G8/8qqFfR8Ah
	/vOxaSOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dm-00000004cAC-3vI0;
	Tue, 26 Mar 2024 13:14:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6dF-00000004c3K-1J64
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=; b=jNQvzvTLyqZlObi8HpJKqoF/ZV
	Th1jWxkaRwFzCUC4SGIab19uuBHT1y0YmVlTYJggN/LMaIxfxRhEVev5HcTO0KRjxRXUEfx4CqhWu
	iKAxoFihnXVUjtET/EBGCs05ApLkIzKrdTp7qnZRSmTyp0+c77zgJlbj34Y+lr3lZyYrMblbrHNnI
	HNC7fWn4eXeMZkF7rqZRYt/nypaAvfNNH8aTRJxzflaL9VhMTLEBwpmw93sSKrDKqThWygaCoEDal
	5g0RcCzEysT/h/qU+O6fsT2RRKXvRMRXTf+7yEaEpDQTHyIHh1KEKoCHcKO+GV3T0OAsyfJHFU+Q7
	WgrBmPKg==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d5-0000000HAxt-3ply
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:17 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A65C5D65D;
	Tue, 26 Mar 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=HAeAza5P8hjdX5I4zpTXSTQVnn2A2DavwNKz6T/d8O9vj2cgwj/kfZqyr+yGS6OiNm/a7W
	5h9kg+korVml+8uUsQdHksW91vPzaegLFjGkxWxHsUHEgPBhKrnNvrzoUdjjXhtpp/zF/V
	kmUyIdBjm2JjUqkXgr80rDHOOxXCToY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=ENftepJ0w6kVH0jY+Avzth5tZyskKUdWYWjoEXwm0p6r6YSA2VUuiRg2CqX2vR3kIgvW3A
	9TzhA7Caopj8IvCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=HAeAza5P8hjdX5I4zpTXSTQVnn2A2DavwNKz6T/d8O9vj2cgwj/kfZqyr+yGS6OiNm/a7W
	5h9kg+korVml+8uUsQdHksW91vPzaegLFjGkxWxHsUHEgPBhKrnNvrzoUdjjXhtpp/zF/V
	kmUyIdBjm2JjUqkXgr80rDHOOxXCToY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRtGljXeRkizLPTdH8AL2v73BEIVmW5EhhtY7H/qPk0=;
	b=ENftepJ0w6kVH0jY+Avzth5tZyskKUdWYWjoEXwm0p6r6YSA2VUuiRg2CqX2vR3kIgvW3A
	9TzhA7Caopj8IvCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 685E813587;
	Tue, 26 Mar 2024 13:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OxoSGCTKAmYUNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:12 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 11/20] nvme/rc: do not cleanup external managed loop device
Date: Tue, 26 Mar 2024 14:13:53 +0100
Message-ID: <20240326131402.5092-12-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.44)[91.23%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131416_075512_83C4FEE3 
X-CRM114-Status: GOOD (  10.58  )
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

If the test setups a loop device itself (not created by
_nvmet_target_setup), _nvmet_target_cleanup should not cleanup the block
device automatically.

Because _nvmet_target_cleanup has no way to figure this out by itself if
it is managed or not, the caller needs to pass in the block device type.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4ad6cb640627..9d47c737f9b0 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -855,9 +855,14 @@ _nvmet_target_cleanup() {
 	local port
 	local blkdev
 	local subsysnqn="${def_subsysnqn}"
+	local blkdev_type=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
 			--subsysnqn)
 				subsysnqn="$2"
 				shift 2
@@ -878,7 +883,9 @@ _nvmet_target_cleanup() {
 	_remove_nvmet_subsystem "${subsysnqn}"
 	_remove_nvmet_host "${def_hostnqn}"
 
-	_cleanup_blkdev
+	if [[ "${blkdev_type}" == "device" ]]; then
+		_cleanup_blkdev
+	fi
 }
 
 _nvmet_passthru_target_setup() {
-- 
2.44.0


