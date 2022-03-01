Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JaCUSD2vTqwOwKJJzKBOPbfZizxvexTnRKWpUjmtfyU=; b=i6l8jGjdpirW/yWX5s4jEdAW84
	zLyffcey0tw37qcsq5LYEoxQf8kufWjKpKWZqeZ5r72buE3sSkDV7H3SxGrdzIpwItdplaI6tyvO1
	NJsiNrdMGHQsvt9lvu6qKseXrQ+6i/LSn058IeJFlZKecc2iLNRD5IoUFSj2c/XroszRUPoxV7aPP
	p4NHarcQTsmCGMVWBFURT7gLihSanoqM15G0NEh0l7MiOyTRFcKUcM+m4C5GZH9jQkImUS74zk8dQ
	i1wJu2vptEm7ujJDhLqxZVSjTEZB8tp+3mcb1GEETGIRBDMZiUWvc61yTaGKme80un5ZZqWCUVn7C
	oP48Ex8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOrs5-00Efvr-HT; Tue, 01 Mar 2022 02:04:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOrs1-00EftP-IG
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 02:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646100246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JaCUSD2vTqwOwKJJzKBOPbfZizxvexTnRKWpUjmtfyU=;
 b=Kf938szk2uK4x1Eag+FbAngOp7BAUOaoTO/OBWeDCq0IO52mddDZHg4ehYxGJ5gLDg7rdL
 ZS2Dc4h+eKqXUT5UGo3T+SaCdLYaohgUrUVjdb2vfw99WeTSH1bW8mBF0uOBBGvVVXT4uJ
 tY9fYX5PYpoGqPWzypm5TaaFwQKmBZA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-8eDQoPcqOOW0Xg8lCRIHKw-1; Mon, 28 Feb 2022 21:04:03 -0500
X-MC-Unique: 8eDQoPcqOOW0Xg8lCRIHKw-1
Received: by mail-qt1-f199.google.com with SMTP id
 x26-20020ac84a1a000000b002ddcbd9e933so6235759qtq.11
 for <linux-nvme@lists.infradead.org>; Mon, 28 Feb 2022 18:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:from:subject:cc:content-transfer-encoding;
 bh=JaCUSD2vTqwOwKJJzKBOPbfZizxvexTnRKWpUjmtfyU=;
 b=g1v/7fBMh/rmwCk6rNitqj2GSO1aADksfEz6+H0kLutMCDY01DLwU1OiAXnI6YQmsD
 6nImgDpgmXNEbKgyj5lPiaMwSyLq0WaN7zcd9Rg+PvdpQOtcjpijJ5w43Zwa/Ngbspj7
 7W9hf4i8fgRO9yjkpYRS3rJuuFEXhEMcsF2oOY4lW8kEpQZoosxGwYHH6DZoXOzAX3+s
 ASQJXMWk/Zey1q3vNXm+++ktBFoBi8hCfhifpEjL1FrN1++FMXfA0nY4EukZxzxosXUN
 Og6j/xe5XFFk0FQCNHDMDw7MDk6Os4z7aG9CdBqtxeYf8ZJXDj0c2bhCR7bkAOQgk7sq
 TEsA==
X-Gm-Message-State: AOAM530FadVpGPWhsJ9G8vsEi46o6MTyAl7yxB99V7gWlLeJwYJ/8ybD
 74TAkqQKazOF0MsO+Pgm9z1jpPfV6y4H8wpY1T7KNZQjP2nAFGu5S2b3/GgqwizzVSs1ZHUUIEk
 EUUbfFGiAzuT8bZ5voM2Eu8oh2Qs=
X-Received: by 2002:ac8:59d6:0:b0:2dd:226:9d7d with SMTP id
 f22-20020ac859d6000000b002dd02269d7dmr18466322qtf.372.1646100243314; 
 Mon, 28 Feb 2022 18:04:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+IUB2hr74QXPnDooszKG62xt16/KuAcFHfGM+WDSG9L0tFQNkmqb18SPuQtwasI3eVUfGCg==
X-Received: by 2002:ac8:59d6:0:b0:2dd:226:9d7d with SMTP id
 f22-20020ac859d6000000b002dd02269d7dmr18466308qtf.372.1646100243047; 
 Mon, 28 Feb 2022 18:04:03 -0800 (PST)
Received: from [192.168.0.14] (97-120-59-83.ptld.qwest.net. [97.120.59.83])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a05620a15d800b00648a9cf86e7sm5779355qkm.33.2022.02.28.18.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 18:04:02 -0800 (PST)
Message-ID: <1cc5dd40-47e5-0756-db22-42e4e86468c5@redhat.com>
Date: Mon, 28 Feb 2022 18:04:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To: lsf-pc@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
From: Chris Leech <cleech@redhat.com>
Subject: [LSF/MM/BPF TOPIC] network storage transports managed within a
 container
Cc: Lee Duncan <lduncan@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_180409_851042_50E01FD4 
X-CRM114-Status: UNSURE (   8.24  )
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

There are various challenges when users start trying to manage SAN
attachments from within a container, and how we deal with network
namespaces.  I think it would be worth a discussion around what can be
agreed on as desired behavior, and what it means to attach block
devices from a containerized environment.

iSCSI has a number of issues here with the kernel to iscsid
interfaces, netlink and sysfs, which are largely fixable without
needing to break anything.  But for kernel maintained network
connections, there's an issue of interacting with namespace lifetimes
without a process.

NVMe/TCP has avoided complex user-space control planes, but when I
checked subsystem connection occurred within the active namespace of
nvme-cli, but afterwords all fabrics subsystems were visible,
controllable, and disconnectable from any namespace.


Lee Duncan had submitted a proposal to discuss this for iSCSI last
year [1], partially based on some older work I did that never
completed [2] (I need to update that code)

[1]
https://lore.kernel.org/linux-scsi/e9f0297a-a914-ba83-f706-5a2d508c666b@suse.com/

[2] https://github.com/cleech/linux/commits/iscsi-netns-old-wip

- Chris Leech


