Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E28C79F82
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 23:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VIk52XWO87XyisUAZMMmHhSekpI+pY0wXT0ih9gfa9s=; b=dL4+u1QdYmLVt/RwBnyMMf9997
	muWmz0pO/+0OUQPily5Ah1hpLrQff2Q5ewpm+V8HAeI25kAq/0w755eAw7f+vGeomq/ylcE/u01uj
	uKKfTKHLNv7AW0io8MHigrJ/q6UGtZx5+BFX137R6xvGMtQbRJtchuPIPxz9QsUjkNorVijbRE431
	D7VFhdsHWRhR9qtZKJW1AIdFdzZbEOnyZJ3zRk72Zghiq09ES6r/LoSxAqWBX5JrDrpDjbtXYMi6P
	nBKnRqYcyVoo20jz8Oq95dDLFqb8TTSthAztA+8T1QIKyrQQY4FmBPGNvH+wxjBRRx72a1as/L0A/
	kFjJlvHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2dAN-00000003SlU-03d1;
	Fri, 04 Sep 2026 23:17:51 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2dAK-00000003Sl8-0kuN
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 23:17:49 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so2140035a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Sep 2026 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788563867; x=1789168667; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VIk52XWO87XyisUAZMMmHhSekpI+pY0wXT0ih9gfa9s=;
        b=W4b0yoa4K9Wu3+Lad9uE1UGUOEPlCJsGDUFDa1A9/alv0TRbNZyHYwyUDin7hry85Q
         cPK6rXp5K+Fp41S6VymV5N6Ykp5+nCZtpGcyG+6hSSnTtPIRDSGH4Ehdibkc64zXxjOZ
         M1VFlCwlFbId4sLwwMcIyqul4S9ULIgYsAQnWCgFDkkluXvMoCZC5Yv2sNqEtJCTEfgQ
         qxPm9IcYRCq/78eiRz7H2JNI2unFM3SrhPTo4J6M5DLw+202dkIlISgnVxKui5As+axr
         rE2mu1P683xvI868aZGPlN2sJGLZLLBO7jjvTTl7GbS//K0VJaHlUkLldvCxeZ4zD5sL
         kgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788563867; x=1789168667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIk52XWO87XyisUAZMMmHhSekpI+pY0wXT0ih9gfa9s=;
        b=qF5uN6dJOITpgHNR8SDsBCCb5S6YbVXfb3MZg95a2WeVrbgitcLJK1wqHnIYGI+c+1
         /mKaAcfjKxjDYT+NTqHK55TWbflWdvqX9cVp7EjN5ajlpxf6ra2XZ/jB1oUw+kytQHu9
         HN/E+AHtSIatBHTOBATxHQ5DD9WE+tzCaJ90dUpZd4/nDWxBjHyQuR9e/pECwe5sdqhB
         Xz59vRm6A3nS3Et52LQdTtodYg18I6YbAYexQiVZDBcCHdAhIHeN+FGvXAD10h7Yfhvr
         aHyKwhqo+JTjTPS6E3tc+Ko8POXn5nXxtGi9yYC4aEBX/01sLvDrdyMdOgI1YtVe80vr
         zVBw==
X-Forwarded-Encrypted: i=1; AKwUvBxes7C3rdByWQjRKSHOhaMy6dzSHNSmXNQbjtR3QfmRYH21cl3tKqoS4NyZbrHGNoOzW0VAoi5gpt67@lists.infradead.org
X-Gm-Message-State: AFuF++kTjfF8cy3WB+B80TTftx8Nptec3u/RXgvyUJ2M/0r9JMHgK+OZ
	sjaZ+YX4b7h5JQqKm9/EQb3Aw/QGtu5N2PnbpMc9o2pLG+ttizRAqah7rX7p0LeXIS0=
X-Gm-Gg: AYBFou16obnz3+u03yVgbTJ7r88rJhMBv3FD7Ti/JVw3T2ylc5cV7OI7BH3O6lMRKFT
	fHQqXv4SxeQhyetBy+9K6XhamK1b/Nms+NEkNd8KIDsNl+IBF5bI+J1kmp8ibWU0+SsOsaKJoE0
	bQFKKB5n8jQdKCemJVYotDnEVE9q1PVglqn7n42tx3iCPJT1YH0ZhFKPCNUnI1Tp7IuQrdSZlx7
	Q/7zjHWQg2pUb9yCw+g+33bX7uIkBVHnsK3ov/rIRDiQDMIdDDhRswAXSgQSEquZVSb/NHhOHRo
	y7xJlFA5U/LuIgVk3NVwfX30a70KDiIlNUNDrVwDN0klVItaQrVFSBDVaTrCFLLGOXq8/dsTMw+
	yoLlxa2PTWLmFxpsWTMDUg92pwY6cUXD8sRSa1sSDWaLiZJVCJ3PBd/XDatgTv14MqOUBvHhh9x
	zQL0wTOYBg+gjOnbGAwuqOVZUlvkQvam6BR42k6SafiqrS8k1m/J5C3T4KryhjBsjqtEW2FymkJ
	CFynSU=
X-Received: by 2002:a17:90b:55cf:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39b261b1a52mr16044908a91.12.1788563866851;
        Fri, 04 Sep 2026 16:17:46 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm14779392eec.15.2026.09.04.16.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:17:46 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:17:44 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/16] nvmet: Implement CCR nvme command
Message-ID: <20260904231744.GE5552-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
 <20260712022437.3743117-4-mkhalfella@purestorage.com>
 <6562686c-1a38-45da-9d99-bfa9a9736fc8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6562686c-1a38-45da-9d99-bfa9a9736fc8@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_161748_225361_63A19C9B 
X-CRM114-Status: GOOD (  10.78  )
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

On Sun 2026-08-23 03:53:03 +0300, Sagi Grimberg wrote:
> Would still like to have it simple where nvmet allows a single ccr command
> per ctrl such that we don't need to build a list of waiters.
> 

I think we need to know any point which sctrl is resetting which ictrl.
Without this information it will be difficult to implement CCR standard.
We use struct nvmet_ccr for two purposes:

- Generate CCR logpage on sctrl.
- Know which sctrl needs to send AEN when ictrl exits.

> Otherwise,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

