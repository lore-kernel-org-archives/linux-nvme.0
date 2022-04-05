Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABEFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoQdw1mErjrNX9b33xIYp4qWGfLpxhzTL4hwpyLlv/U=; b=EaB4Hs5ZrGBXs7hcTgP2mxPTp/
	FL5rK3+r0cEgE7ySpkGq9adWW6LrpP7RzPktIOe8RPnmyq1qZMfSdAmWxxnzuvK6jpYcs0B0W8c+Y
	DBRRJsXrNfDua0TKG3BaKK9MbgdvzfGaIqjwrHHC7R1rdYbvImltvvInluMqxNaF7IMSNQcY5TjPm
	lowdAHR9iqL4EAPZYQP2KCFibRHp5SNswb16WHHZ64SfPaU+NhYMPdJT70k/ld7fNqxVcVpcnX/Xg
	InmH3kllPNLxkd6a1ewerKbSdCu4y4IQh2CrWyvqG7NadLztaIjI+E7RQiBzosFgHGcM3rmsuwUsR
	oDlqkEuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbkht-001aaH-NZ; Tue, 05 Apr 2022 15:02:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbkho-001aYL-NI
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 15:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649170970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PoQdw1mErjrNX9b33xIYp4qWGfLpxhzTL4hwpyLlv/U=;
 b=fJufTM7ZDjkbioeGapn81u8gIrPR07+BL/iJEYVDH6EKnHaGADFhySfLRik1Hbrg1zB/ik
 PP9n1Sclxx0qknbUo8g7u/iQtTtUbksAhbsgZLbMl3c055jB5vfD8TppdETKN2UlyTrbbZ
 STrEDsBrrotiTQV0Ck63aH9nyYMPWmM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-YY97YTLsNnGVGgZoJC53xg-1; Tue, 05 Apr 2022 11:02:47 -0400
X-MC-Unique: YY97YTLsNnGVGgZoJC53xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8771728092C6;
 Tue,  5 Apr 2022 15:02:46 +0000 (UTC)
Received: from [10.22.18.217] (unknown [10.22.18.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40C4D1C554;
 Tue,  5 Apr 2022 15:02:30 +0000 (UTC)
Message-ID: <047a64f5-bd4c-2c76-1b34-ab6ea969940d@redhat.com>
Date: Tue, 5 Apr 2022 11:02:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
 <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
 <20220405060946.GB24073@lst.de>
 <66428672-250b-950e-ab7c-0a6ceb10c06e@suse.de>
 <1ff01a7a-2687-4a90-672a-e9218cc54331@grimberg.me>
 <13c13023-be65-2b54-cc6d-ff1161a28f54@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <13c13023-be65-2b54-cc6d-ff1161a28f54@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_080252_892050_4452DDD0 
X-CRM114-Status: GOOD (  26.27  )
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

On 4/5/22 07:12, Hannes Reinecke wrote:
> That's what I tried in my first attempt, which got rejected as it does break existing installations.
> We could introduce a module option for this (and I think that's what I did in my first round).
> And yes, ideally I would like to have the discovery subsystem as a 'normal' subsystem just like the others; should be trivial to 
> expose the current one in configfs.
> But then changing the subsystem NQN becomes awkward: > - Either we create a new subsystem with the unique NQN, but then we have to change the type later on (as creation happens with a
 > simple 'mkdir', and one cannot really pass arguments to that).
 > - Or we have a distinct discovery subsystem type (ie the idea Christoph mentioned), but then we have to cross-check the
 > directory names against the existing one in the 'normal' subsystem directory.

I don't think we need to change the discovery subsystem.  I think what we want, in the simple case, is 2 discovery subsystems: 
1) the existing well known discovery controller with the well-known discovery NQN, 2) a unique discovery controller with a 
unique discovery NQN.

The first well known discovery controller exists today and doesn't need to be configurable (unless you're going to do something 
stupid like support fabric authenticate with the well known discovery NQN).

The second unique discovery controller can be configured just like any other NVM subsystem, but its discovery log pages show up 
in the well known discovery controller log page with Subsystem Type (SUBTYPE): 03h - as defined by TP-8014.

So the well known discovery controller always returns log page entries for three types of log pages:

NVME_NQN_DISC,	"referral"
NVME_NQN_NVME,	"nvme"
NVME_NQN_CURR,	"discovery"

When there is no unique discovery controller configured the NVME_NQN_CURR log page has no entries and everything works as it 
does today.

When someone configures a unique discovery NQN, the controller is created and all of the NVME_NQN_NVME log page entries move
to the new unique discovery controller while the NVME_NQN_CURR log page entries on the well-known discovery controller report 
only the NVME_NQN_CURR and NVME_NQN_DISC log page entires.

This is one possible approach.

> And, of course, we still end up with a defunct discovery subsystem if we create a unique discovery subsystem.

Why do we have to defunct the discovery subsystem if we create a unique discover subsystem?

> Alternatively: if we're going to break existing configurations anyway (or, rather, have to modify nvmetcli to handle the new 
> discovery mechanism), why do we need to start off with a default discovery subsystem?

> Can't we require the user to create one?

I would say yes. The user has to create the unique discovery controller and assign it a unique NQN

> We would be requiring a module option here, but that looks like the best approach here as we won't have to deal with stale 
> subsystems ...

I don't understand why there needs to be any stale subsystems.  If we add a optional subsystem (the unique discovery controller) 
we don't need to take anything away.

/John

> Cheers,
> 
> Hannes


