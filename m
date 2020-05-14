Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E6CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 15:37:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6342065D
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okMicRnq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpClB+i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6342065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jEgrnf/QAblJqAH0RzIc1h1AB/pwXFh0OzfCzrR3uYI=; b=okMicRnqwI5NpQCt4cguxtx9u
	hiY3IAsLIi2AoNyFmu6BBSxAtjuFZOkjhHwMlZ6uhfEbzgjLgVeUWYknUxrClA4KhgnbRO32jRuAS
	m2ycwO3KZRx8grn/1CWYPdXVxIlaaIoZsIodJ+dR4BFl+DCr7HfYVL5P/xBR02kaDPCRfAtZo9O1/
	0fak1/UV3pPfiQndN//gShLUJCyRIlwnI4ijsO//dJOMF9gfG3GtTZ0ZEUFCVQ1vfUlNSvKO4JhpL
	urPCvONyxSBiMtvUR5RzGjE1xbUMs8lWtF0cnD2tH2CQya20CGsKkAjfT4qL6t1as8on6B1lLJUo1
	zVJB3FBbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZFvS-00012j-Th; Thu, 14 May 2020 15:37:34 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZFvQ-00012D-DQ
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 15:37:33 +0000
Received: by mail-pj1-x1033.google.com with SMTP id ms17so12610330pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 14 May 2020 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5cLxUxzwN3szHfuDH+3ZfYxmnSN7qzKwIPmMuAJ460E=;
 b=VpClB+i8aLOEQF9RgchxzOhKuBSg1Z+HkWY9YLJ29Dj0U+OXuPfBDmp8Dv4b3NZ/d5
 m9PF04AoOUn9kvJO6x0HDYYMHcPAFvJEK1Yq5mQO1qqwwwiFcpXFm28l3XQwTk7SuPSt
 3LOy0MDizx25iZ8Ife2LpE1/JcTDxPIxWPAy7KQmlI0WiXBZ2HZxduVmaj2smaKuPU0R
 0Xh21AtZgQLN6M0SxOewBIDgxvMKGQHUvqbwM8mwwnfuTo3pGjqbyxuupUv5g2GGcM4E
 Mlw/C/ScXUzi1wHow4hwVP9yCSspnzAxEradC5R6+LH/l1OkKOk+MeHPMy0prECP2GQD
 aFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5cLxUxzwN3szHfuDH+3ZfYxmnSN7qzKwIPmMuAJ460E=;
 b=Ai9rhA957jC5drgjP4HfjRGK0JbuwKbWrbJZfaeoUMDl/5B9WcyDgftyr++Ckch7J+
 KhUmZey8ql95wD6ZM0zLPZ/TavcvWp+LvaJMRr1YHjMuwL27vpTFxyT2+Cr75owo6d4Y
 Xl8r6osmf+GHUaP38YsN15E8fjJ8QgYEpPiIHSlMLwIeBl7VwELE1awUurJs4+mHQCPZ
 5BoqtbttHywQWq/t0Vw8IVzzC6DmaUKZjuRTiaHDp77nE+tpOEobP0WZv5fSavftr61D
 SQuqRQVT1p5D6aTgCRmIeO+x3nov/J7mfVZBzlGJwFApia4/6Rs9mGJJv06lgBv210td
 Y1+A==
X-Gm-Message-State: AOAM531vpR/Stq0d2ussnwPiPYP40gTfl7FyWvAo+4tNTSEu63dBuYN1
 m1p7W65/ThBTQc2T9e3Fong=
X-Google-Smtp-Source: ABdhPJxt63RVf1Xltif75v85BN7CnbTn0RRQyOL9UBpVIQE6nuaIltMzyVjJVU0hCOCDeybNTkRneg==
X-Received: by 2002:a17:90b:4388:: with SMTP id
 in8mr16281078pjb.4.1589470648643; 
 Thu, 14 May 2020 08:37:28 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b8sm2587886pft.11.2020.05.14.08.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 08:37:27 -0700 (PDT)
Subject: Re: [PATCH 14/16] nvmet: add metadata/T10-PI support
To: Max Gurtovoy <maxg@mellanox.com>, James Smart <james.smart@broadcom.com>, 
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, axboe@kernel.dk
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-15-maxg@mellanox.com>
 <0599e55c-a9bf-75f6-5df3-9558029712b8@broadcom.com>
 <ff45413c-c43d-010d-68d9-d48b23693cee@mellanox.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <656ec73d-877d-33d0-3b4c-dfcad5349383@gmail.com>
Date: Thu, 14 May 2020 08:37:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ff45413c-c43d-010d-68d9-d48b23693cee@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_083732_452788_521C6418 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ok - I'm good on this

-- james



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
