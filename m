Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EA606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ncs/N0Ai;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DA3jZCXK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HjF+1SNTBYmoTbto41QlFak1T+ojAX8GDSGPxlX7PUM=; b=ncs/N0AiJZi3bF
	53weI6xv5ffx1ZvXAdI8k4fQMsxWpv55y9LkdAmtdRqmDn5F+sK3D6JZxn8xdcHuzEv2wIaVME8SJ
	nj3Upjby0IXsHCZ5YVvBot97CkgqhnFrcW1pt86aJtfDuf+7/ymcTQaMxKh7SqAoYMGykLdVRd5zJ
	V3S4Q0WQq1IuNPHH4dll1/OyPYkTz0WG/lkZcFwCH4e5f+TkgInOlXlDR9CRxXHDaX70hWxrmuyFG
	NN1KqlXCc0YEsNVL4iS6Oggsxfpk3EuGEZZa4+NGeZRApP+JyMc9AWLBei6TH/hX+hxZJKP88lsGN
	QUATMRvaXPj4BEy3xJPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEXy-0000000AHtw-3u7x;
	Wed, 25 Nov 2026 15:04:35 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWEXv-0000000AHtK-1eCt
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 15:04:32 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso2943994a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795619070; x=1796223870; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjF+1SNTBYmoTbto41QlFak1T+ojAX8GDSGPxlX7PUM=;
        b=DA3jZCXKDxeW3zo3rYCzesD2k7v5O0Zj5PAIAY/3km7zgrUuJKl2f/ZNN1xdhZceyX
         eVTmIC26e/9Wx7OVeYzIaf18AmHulKbkg1q7t1Z/fX9I5z0cniyHN3UVOwvRtsrvwTJa
         A9oEUCEtPS+6Fn8cWgY37eGJRJBjRUQeaKOAPp3rOan1rPHn7i4VSYfh9OuGUu/cSe96
         won3ji020QXHtDuczLSTOV+Tm9yTQSs1U5CDcmeJiuHoD9+9QXtvqkzrQ3CTs6H4ezn2
         AVsF0jTPLG/o9p25micrV2hAYVcdQUsiPDN5swZnIH6NU7E/gZRVsGKNUXXcMQK9NXJ1
         fvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619070; x=1796223870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjF+1SNTBYmoTbto41QlFak1T+ojAX8GDSGPxlX7PUM=;
        b=0kP5jtdyL1A1SB/Gimrown4wPeSKo5hWa9/0ssR3gJmhP/Wa5AqYxO1Z2ld7Lh52x+
         ZsqjGDCRb0DzfWWWa62z9LELNoCq/XLlVRkjfX90n/CzN8DQGYVLihFaOHvlXk984kSo
         o0vU6JjxIwhd1pVosqwMCl++djdwSxClDKqecjCsiBA6jpnWqiaiLFaNkafjjqro3G95
         zc4D9HDvLmktOwIaCRyuDEgUOaRCAenyg7v9EZjrNLGhNsPvAVb1boJqHt2nXcxGlEj7
         03+vtNkmbv50kQlt2Xo1/n3jQq65d/LuW3HlWqh5bCGrwIMOagtjCyp3qyldzBEM2ekC
         QJAw==
X-Forwarded-Encrypted: i=1; AL+hErEgPs5kbjvZdCCOiNSvQOZ4EGr+GFhqJ8Bf7g/epiKQVYvcC/xF87DcVcN44xYfY7cMpDQZhZzHCjb4@lists.infradead.org
X-Gm-Message-State: APuU4Z9Zp+nDQKWZkUmmRRmi7+VdTUglAiPVYx3J78xJyG3zywxzLbHC
	fKorgzzo05o0Jlf1y2RQPy7JjAboN2kiCJrRocK769XD7iEcQTzp95okkG10FlvTuio=
X-Gm-Gg: AZFdTZff2digLfSo73R0zF+ezkmooduLJexDD1XcjYWTLTo4HxTU6NPTjrUhvmxUyDX
	k+Zva6IFKBNAUil5nWWL9TQp5Xj3tEidvcmF7QL+MuVQE6+ji8nj2bGmlLeJOkc6lzoTcs+JAnO
	t2ENXZxSV73B8I14NCATsQWoNcriLqIK/gBK4LAJDlzTqezG3KJjwwa2wYUfkuGZdG/4Qo4EQzJ
	ZMbS7KIeNOq2ElhvTzgdN8uIxvru1vhWgDIfEIOZxk0tFCITWv8q6LCbWC1KeRcvrQcD9wNkW8H
	+XMqZNCarJ43Eu0+bVAutMEM/89icczHWwADZtph1F+vBgfzS9f+ErxM8Hf3VuLo3aXcybf5PTL
	VwiKZMU2s+FvdMZ17NHEdoyvwi+7t/0XREZbwymm53SCsUIsjyVjbpZ08GUbeC7/VmFowWeH10r
	cBvOKh9igYOOOycZsJrNswQxifzdUVfL7qRnr/l32HR9JXV2MQ/Hzxz2zZSbPVlhjN/8kua/3wl
	PrzlyN3Z145IdLxk7ciD+fCZ3BQCqLieVvrKWDbVCatpyNuiva3Bd9kVgaFCZuhSyKSC3UbweYY
	NzE3uImbOwrCOfzcrUej3Ep7UsMllsY0NTIMYvrD/p/HEzbNF4gPdAaMtjyIWp6gVEG/KJZzDct
	BVipXNmthXd76SwxkgjAXp0cPMmaA0yI1+3U+Ew==
X-Received: by 2002:a17:90b:134e:b0:3b3:c2bf:de33 with SMTP id 98e67ed59e1d1-3b41c93a017mr15614182a91.40.1795619070369;
        Wed, 25 Nov 2026 07:04:30 -0800 (PST)
Received: from localhost.localdomain ([2406:5900:1044:110c:6ad4:29a9:2f98:35a3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b73b2b3sm13249130a91.2.2026.11.25.07.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:04:30 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: kamaljit.singh@opensource.wdc.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject an administrative controller type on reinitialization
Date: Thu, 26 Nov 2026 00:04:24 +0900
Message-ID: <20261125150424.255188-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125051608.GA20096@lst.de>
References: <20261125051608.GA20096@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_070431_428572_1C56781B 
X-CRM114-Status: GOOD (  11.67  )
X-Spam-Score: -1.0 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 06:16:08AM +0100, Christoph Hellwig wrote:
> Well, we'll have more issues if a reconnect changes the controller
> type.  So please check for that just after issuing the identify
> controller and reject such a shape changing controller.  And please
> cut the commit message down to the basics.

v2 does both.  The check now sits in nvme_init_identify(), right before
ctrl->cntrltype is overwritten, and rejects any controller type change on
an already initialized controller rather than only the I/O-to-admin
override.  The commit message is cut down to the bug and the fix.

  https://lore.kernel.org/linux-nvme/20261125145902.254297-1-yhlee@isslab.korea.ac.kr/

