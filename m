Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353C5C35FFF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 01:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nK0OvSq0ywdKqmElV6yaatX6YHi7pa/TyALxUsilWPY=; b=OABfZqIY26TNJQ4CaXtEmZchbj
	Luv5+UD/klIOhqbHKJYH2Xhudj04qWFRS06KPUkVZ1xa6IDj5e7oBpFx6H+slnnomH/t7EEjZZZuw
	zsJyrdUU+w5DI5skhnfSiS2CU5iyPhZOsJGIQtcTNJK4AOq+HsgZa7B/jy38mifi97goFXf+cA7gE
	ol2yV0WJN/tshygY5ZlXzTchs+A05VvHd0Dmmu8z7cswUGr2kBG6k1SyJkjitPGzyR9Io8+trGA7W
	aETxH7uYdF4DaEqY8kR8U0s3SL+iy8Sj3hBsFLqeV61HgLgKDddQwzo7FWeCupbFvbYKMaRn8Vcdx
	RTBjtQpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvRMd-0000000DeES-08jM;
	Fri, 21 Mar 2025 01:39:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvRMZ-0000000DeE6-00Yv
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 01:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742521191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nK0OvSq0ywdKqmElV6yaatX6YHi7pa/TyALxUsilWPY=;
	b=gH1t39BUPyOO81kcUCGLDe9MAq1vA6BnpJqtSMLLkRMNS69rbYS/drG1Kfz5ySnUSS5WBQ
	ejA1gOzU4ikBZ53mtloibxuBfxA8nHZKzsk1qKpaYlV4e/ZgMC3luyO0psBqCNju3iJY1M
	LfwHtiaz0vDYZiEbHs0XbO1cIYd/Rmc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-UyO-f1-3Pj-RLwQvMSi_eQ-1; Thu,
 20 Mar 2025 21:39:49 -0400
X-MC-Unique: UyO-f1-3Pj-RLwQvMSi_eQ-1
X-Mimecast-MFC-AGG-ID: UyO-f1-3Pj-RLwQvMSi_eQ_1742521188
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755F71809CA5
	for <linux-nvme@lists.infradead.org>; Fri, 21 Mar 2025 01:39:48 +0000 (UTC)
Received: from [10.22.80.230] (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D4611800370;
	Fri, 21 Mar 2025 01:39:47 +0000 (UTC)
Message-ID: <ec9b97de-68d2-43d4-9f76-65d4be91d49d@redhat.com>
Date: Thu, 20 Mar 2025 21:39:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: John Meneghini <jmeneghi@redhat.com>
Subject: [LSF/MM/BPF TOPIC] NVMe Cancel support
Organization: RHEL Core Storge Team
Cc: Maurizio Lombardi <mlombard@redhat.com>, Chris Leech <cleech@redhat.com>,
 Ewan Milne <emilne@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ynVa_vQ8ubK6kiRRedoKxA6vib1i7dlJGHKql_rsVrs_1742521188
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_183955_122764_55316D9E 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

I am scheduled to present on the topic of NVMe Cancel support next week in the LSF/MM/BPF IO Track.

Here's an abstract for my talk.

The NVMe Cancel command was added to the NVMe spec with TP4097a back in the NVMe 2.0 time frame[1].

At that time I was working for a storage array company and was personally involved with the
effort to add support for this protocol into the storage array's controller.

After moving to Red Hat in the fall of 2021 I started working with my engineering
team at Red Hat to add support for TP4097a to the Linux host.

My talk next week will present the latest version of Red Hat's patches - which are based upon
our previous versions[2] submitted for comments - and discuss some of the obstacles
and challenges we've encountered during implementation.

Almost all of these obstacles have to do with testing.  We've had these patches working in our
lab for more than a year now, and we are happily able to send Cancel commands to the storage
array with no problems. However, these tests are not sufficient for upstream acceptance and we've
spent the last few months developing the nvmet patches needed to sufficiently test this feature
with a nvmet soft target..

I want to share those nvmet patches with the community and discuss what the possible next steps
could be to get this feature accepted upstream.

Many thanks to Chris Leech <cleech@redhat.com> and Maurizio Lombardi <mlombard@redhat.com> who
have done the lions share of this work.

[1] https://people.redhat.com/jmeneghi/LSFMM_2025/TP4097a_Abort_Enhancements_2021.07.26-Ratified.pdf
[2] https://lore.kernel.org/linux-nvme/20240912081510.171857-1-mlombard@redhat.com/

-- 
John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com


