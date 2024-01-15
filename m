Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41418C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KP1mjA/Jtm4Ed5nmaHkkLFUo5/5PeZmLyFfLtlMfOJ8=; b=VttK3xTLjXzEazpLPaAFo9rHzp
	LLIhWK1OkP1dje+n0qjOW9M8Kiux4WzK4yq+V75RpewCdPW562UtBZ9N76grimRWSx6fNTEGtzD6k
	2BRi+tFc7VAz3gCGOMMwHUCaHZ0pmt+wxc+HeP/KMYhQY1qqJnQqC6QU7ozIfecF1PYOeZoQxdhhV
	/F+o+6Gqd3TFsc5Ev0eYBZ8mrfoK8MxJZaIjm+TIyUiO8Y/cOGkdV9WsFfg69x2T6q7FDEtMlBqU5
	w0S8pAwEJVy10QSjlhZKWpWNaDwO9lRI4pPMJnuvep9mutysBqi2PG6/zkUPbvDm9S+RBl3jpa0rT
	/JNbf4XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPO3W-009Edt-2e;
	Mon, 15 Jan 2024 14:35:14 +0000
Received: from sendmail.purelymail.com ([34.202.193.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPO3U-009EcS-2A
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 14:35:13 +0000
DKIM-Signature: a=rsa-sha256; b=cvNKMd06xziHmHZDy03AkcAuM+wucxisEHgmuXf450/QW6UHuUhvK2X7P2HYL07bUBK0E66s7+EBUPHicWNtX+CDBlP+wVyKHL5C29WUrtUyOwaIVkKDshq48qdiGSn4EM+ubEwtFJrG3EC8e2fbfP6t8wlDV5uqsjbN2ajGf0A0rXoth9bMQT/jZ8gHLU034gnhmoA4z/bolyy9j0ZmTuiAUrdYOAL1B8w5WaOxuznixer8/3x3LrWLzmz3JZCiD8qyd3uDYpljuy1vnQx+z13dD8hDMdEwT6+aj5xXY2QQ2iLJlSgrTOX2NbZlBpouzKOV6VCinujVK/kQoF2K6Q==; s=purelymail1; d=saulv.es; v=1; bh=cPyE0liZOCSpkS22WCSO/4qf4VrCDp5W8KzcQkygRDM=; h=Received:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=rOzZh4VJMZVC+2L6UipNo5N5LCTdGQZ+PYIDFoltUW1lCTV+kSzTX6uD6D1KJmhdUrL8V1f+g/x4XYo3xvQMsXqg9J9aabe9ihRQF6CXjXMXYTJWeQHZRf3MiPV1hFsybClzK29hmo6NExTQFmLtKs8n+5P7Cwnm1usSVleAHBj1y7w70Og+a/s7ELnT8k+9Ks6ESLD8IOtNRyunZcbDQAGt+3dWUM1pf2XXBWXbek3hw3EqAl4P0hfhq7Ipaa0aRzyNIorw0d0c2G7IiYkZ8RB4aIEuHgDys4tf6ypjtTMOv5grf5YlhY70kZ+jdywOF12+7HpEpQ/T/ThgA8xM2A==; s=purelymail1; d=purelymail.com; v=1; bh=cPyE0liZOCSpkS22WCSO/4qf4VrCDp5W8KzcQkygRDM=; h=Feedback-ID:Received:From:To:Subject;
Feedback-ID: 13394:2854:null:purelymail
X-Pm-Original-To: linux-nvme@lists.infradead.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -751213925;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 15 Jan 2024 14:34:56 +0000 (UTC)
Date: Mon, 15 Jan 2024 15:35:10 +0100
From: =?utf-8?B?U2HDumw=?= Valdelvira <saul@saulv.es>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Message-ID: <qy2em323bnjfuy5if2yyxw5qrzurplltlzqgpg6xpbnh4hfy4f@olq7qyaudjcr>
References: <20240113213012.30898-1-saul@saulv.es>
 <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
 <lnfpduryv5nwibiejqxnvohr4pcismnkyzkowqvit3gkpdgt3d@ojcvlonaolzu>
 <df8864fe-655a-4890-a19c-7fb69513aeb5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8864fe-655a-4890-a19c-7fb69513aeb5@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_063512_780724_1DB1E56C 
X-CRM114-Status: GOOD (  10.80  )
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

On Mon, Jan 15, 2024 at 04:28:36PM +0200, Sagi Grimberg wrote:
>
> Strange. Not sure why it wouldn't work unless the vendor/device numbers
> are off...
>
I got the numbers from the this command "lspci -nn | grep -i nvme"
The output was :
"04:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue
    SN500 / PC SN520 [15b7:5003] (rev 01)"

So vendor id is 15b7 and device id is 5003, am I right?


