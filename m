Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A99E7718B
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jan 2025 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NjRUKLD8Bumt3e1+J2Bl6B2+88r0rX6AZyUAIAx2O50=; b=z077LmySOB13ptetOweePbH/Zl
	oGQx220OZyGNE7ppBgbgk3GCZPwN9DJ/oT9d+L+mq70IxiQQp0RXLuDm5FGfCfkCNRIY+yjuYdeGA
	Fwr96PQM56+gyLDGwOeFAQ/rmORObU0Xrw5GbcxgmoK8ESxTBynjbcOk3k+tpkh9stryxeJ941EG2
	jAiQ0A8kOA/XSNZWSJayWdtF03tfdYnQKWCmnR4E8c21uIsn4PC170eOQBNObNWVN3Bo1hixu72hh
	AdDJdUsVSwG8a2WlFiwISMK4ZDYxrulcfiwCM0AhUZH9Ol7tj0NUiy3b4qdIPt1A9YUpt4P6Ht7wT
	0epHmciw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSsK0-00000008GXt-0NqX;
	Wed, 01 Jan 2025 06:35:12 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSsJx-00000008GWn-40Gh
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jan 2025 06:35:11 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-e46ebe19368so12201371276.0
        for <linux-nvme@lists.infradead.org>; Tue, 31 Dec 2024 22:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735713308; x=1736318108; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjRUKLD8Bumt3e1+J2Bl6B2+88r0rX6AZyUAIAx2O50=;
        b=Xe9Yvo+7hsOodUHTn0QfpVqqYpZwHNj8F1VoO3BHIQjpUq9j1xXltxpNRySgilk9M1
         ML3HQAQyBtC3egLBSKkd0rb1ur9SNxV8kPIiHYnnu9v4LMwQpl01+DZ86BBGvSdBeFXs
         lKitLGtbg/AoBLI4QO4xFqYbHSL1eVMC06OUh9DywPSnwSnyNtovTupqAn+npzOf85mp
         pRpSJ89tzN/t2P65/dbzmp9vnDbyYKYFA69YvFrqOhU4Fpi0Wi9NmcFaYMSz8xHVLGGG
         fJCLWiRxa/8FDgRj8FAPtGqNfJLHzlU6a4AUr8RHxPSeq8Ue3FMjjEv0opZRIwQ0IytN
         QsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735713308; x=1736318108;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjRUKLD8Bumt3e1+J2Bl6B2+88r0rX6AZyUAIAx2O50=;
        b=SxkqZeGQb0VRiOYj6M6sQPuSPySCsucQrojr7HGcAsvfDjp9Umwjd0pLciZKqEihFy
         lkdQi4buQRazx3ugtIFkjerDaoPYGDKHFqS91D1v7+8MZg+rCvvUGqrjDXLeqzWr7n4J
         6f5ORujiy8MWaWui1cPKw25KOa2nJj2zJo+Vonqw9vS4s+SulN39Er4Sxevuyq4I6Yod
         AysWAAFqwnbwJmkHenSbUcJDyOmCekVsBa7gWuF/gJq7wQNLqkInEUmhfibDSjIgiSsf
         50sdHtETEz4eCTWMKYntry8VGgvS1AwLFvYwyys26IiVkuRbVYAqmzxs/dK0odiH6bYr
         ydxA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwq+RUYGirvWZxOR/uHVaK3LBIDJVOD6AAnbMpW1TR8NZtdwmiaIbR2Aibs2kdAE9mRhMKsxoy2RN@lists.infradead.org
X-Gm-Message-State: AOJu0YxEzaMDz6DsZCndOgJmYOMnOyKZzy1zJhqwfUcI4nLAcBF6x0DD
	/Rf0B2jj4VqMjOLIAPCBSLAMyEdekdNg6iZI5/hRzQrG9LgjsKz5bbmxPLMYoOzAROlIsExuaPV
	1dhTnhHCbM68tAr823Q2gvqaRo4o=
X-Gm-Gg: ASbGnctyiuQ1hwusS45UlkTOwbSnLDf/2GsLqGS6ORKGArPNciIWwomzEKA03/EQdxb
	ZUW8Pdjd29YiAwAHf+0LuqPLBulHw/ul5ymoNn2w=
X-Google-Smtp-Source: AGHT+IHOu/oIRhG13MDfx4abwpJNhF+F8OwNmkbA0Gt7/LClFpyFuL773FGv7SRH8gVMM++xgNLIaY4G/mZ0C9lv/Ok=
X-Received: by 2002:a05:6902:114f:b0:e4a:ea18:b44a with SMTP id
 3f1490d57ef6-e538c34ee63mr21280890276.38.1735713308394; Tue, 31 Dec 2024
 22:35:08 -0800 (PST)
MIME-Version: 1.0
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Wed, 1 Jan 2025 12:04:56 +0530
Message-ID: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, bpf@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241231_223510_020781_A9C0F7F0 
X-CRM114-Status: UNSURE (   8.20  )
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

Dear Community,

I would like to propose a discussion topic regarding the enhancement
of block layer tracepoints, which could fundamentally transform how
backup and recovery systems operate on Linux.

Current Scenario:

- I'm developing a continuous data protection system using eBPF to
monitor block request completions
- The system aims to achieve reliable live data replication for block devices
Current tracepoints present challenges in capturing the complete
lifecycle of write operations

Potential Impact:

- Transform Linux Backup Systems:
- Enable true continuous data protection at block level
- Eliminate backup windows by capturing changes in real-time
- Reduce recovery point objectives (RPO) to near-zero
- Allow point-in-time recovery at block granularity

Current Technical Limitations:

- Inconsistent visibility into write operation completion
- Gaps between write operations and actual data flushes
- Potential missing instrumentation points
- Challenges in ensuring data consistency across replicated volumes

Proposed Improvements:

- Additional tracepoints for better write operation visibility
- Optimal placement of existing tracepoints
- New instrumentation points for reliable block-level monitoring

Implementation Considerations:

- Performance impact of additional tracepoints
- Integration with existing block layer infrastructure
- Compatibility with various storage backends
- Requirements for consistent backup state

These improvements could revolutionize how we approach backup and
recovery on Linux systems:

- Move from periodic snapshots to continuous data protection
- Enable more granular recovery options
- Reduce system overhead during backup operations
- Improve reliability of backup systems
- Enhance disaster recovery capabilities

This discussion would benefit both the block layer and BPF
communities, as well as the broader Linux ecosystem, particularly
enterprises requiring robust backup and recovery solutions.

Looking forward to the community's thoughts and feedback.

Best regards,
-- 
Vishnu KS,
Opensource contributor and researcher,
https://xmigrate.cloud
https://iamvishnuks.com

