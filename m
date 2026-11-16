Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7A606A881
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R6KdkrJx;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8/EWq23
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=; b=R6KdkrJxcJBtaA
	QLYR86rAoArXtVWjSeY8bEHXp9tm/DmenG+/LTAiBK1Ee3pQVX2D6IaXFe/pzT23jxO617zW5Doz0
	fiwy1GQwm2QZDsBDqrhlqpoXNRZnAnBBOXo+Jwyr8My6nBj4cBiRXlmHXBQuNyv71sEdwh3Zd0dX6
	nW+trQFBy3qG6/5Aej/BQY0JHCwcvsywK91njLpwLiqvGR0rZz0mkDNcnbn7c/IHa6dC9y7DdPAGC
	w99IxE2X/HrcmSa+lv2P3bLt3OwmmkBZGhoI3WuMfj6CSamVe7byaawGnmLr+clzc133ZCJ1JsY8A
	2owaPB6zzFl508bWTjDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzJL-00000003AVD-2hS7;
	Mon, 16 Nov 2026 16:12:03 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzJI-00000003AUo-1D0G
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:12:01 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-15dd124bbe7so2159945c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794845519; x=1795450319; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=c8/EWq23oljyAGvSDI3ueWWIO6OSwpdgq6H1FOiDZvHqlIxD62+06yqAekfra5qV4+
         z4iL9zMxHY5lax0q+J5CCeIq7ekDchpe6twgslVhAP7SxQaabzvWhuU9FM1THKzn1x6V
         XHhabOeOjlorIUaF0RBl1H1xByvdPiHHlCNHTg5OxZ73xUi0xx3z7732ABcg1Gq3dz/y
         H/2IMeXzMi0UoEhluXz3KrpJ+9/PwiUMkKnyDxSi32UD1VmUfqADsLhQh13h39NDcmYp
         OvYP4hwL5AkXRQnShiT7ROMYWzUqJWFcBW6RiEbfQfAj92b/RPG4SHX0W05MoXp73ncw
         kzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845519; x=1795450319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yKYud9p8+aP8cT7V12zkUbmCop1ErkdHEczU+hWaU/k=;
        b=MVvvzB57BgRlL6rESOAOyg67ptvvCiKIbt3hP4G+U7hrnpmHFPmFuD1EL57RV0WZyD
         Ow5FSggEOZ356+GWQT1JvLumM3MIak4+AsCkU0xx9mseVzAw1ZnwK3VfaJTuGgDMnP6q
         SRwQKthjqPQlUIXJu7+3ukTDAuMTsOvkACCj9LIiLwZkcOPH8NB7Fqnas95UI0/sTE/G
         cCV94YqKVIXxbKZxikdYHcuXx7c6nAugCUpPbTo/u1CnTR1x4zqat+E7kaatx09IG5XZ
         dJnTVj+wSnfPAJ4jGUW5AH1LoEmcDCCIbFvzIV6neEDEltINdIPXd1X95eHWzttY7gIN
         ZhrQ==
X-Forwarded-Encrypted: i=1; AL+hErFX/TElAUkR6GP7z5phVFA4CLVSxmtWoaxIcSPR1kVlcv19uOTL7zmZ1zhCaYqrGaRQUiDz4OJZFI4t@lists.infradead.org
X-Gm-Message-State: APuU4Z8DqfGPppEZsXcoZBkgUwAulFs/qi8PWmp3YfIsZ4kHOOSUJDlQ
	ydE6fHmJBs0dNeW+BXKR9aKW5ZiPE3XiJtGRyOK3/31aCToymzPZB2CNkf/AK1sQ
X-Gm-Gg: AYBFou1qZeDjiuc8sgm0KEstk5zSUSyDZ83HFDKn7Sxxcxdy3/L+WJtdEtKKoRry3t7
	MuVKGkJ9nlM2QlvdClX19tuBZXry9HqApmX3oCQUslcZZTD3EbZAjx8P5Q7qupe+6GpJs81C/fv
	9tKDx2xGfzPSD5DlIi/1JwVp0C7iMfXVESRGK3/DyAyTYEAxNZ22EQW423sRE798UCtrzNW1rHP
	vQa556MWctjNMZ9ID4bdwhZiOqOcoI9+F9bm+r/qtcF+olhpiF52QtdpI9QR4jr7tw0F60OqH6e
	57IwGE0TjRlR253habqERf5EpnN5knGBrL5R26zBRDthEyFx+DJuXad29JRzMZVegthHAnJLcsK
	gLHylL2pK4IFVlg1gynlL+NgutDGMJK58EhUgVBtGQWC8lhH4Y2x+yzJcCOVmQDyw3NvevACCwz
	2wvqH5Ujz9zJbXDjaRuluJgiH3AwOIIec6YMGL9LXryzynoD1z7B6YmoCi/nxj++LT1IISJhMvP
	8c0klWs9FeP9z/+gR8aDysr5WEHARsaDfEBlW1oNvWOW1cR8OAydSut/q5STtejaFjr2kHEbyYR
	B8XjUdi5PNShbZYbOHcOoOpX5HrwlTXwy8sNWBBHO+Uk1PvAs+k=
X-Received: by 2002:a05:7022:2529:b0:1b4:fa58:9d8 with SMTP id a92af1059eb24-1b5031759b2mr15999570c88.20.1794845519181;
        Mon, 16 Nov 2026 08:11:59 -0800 (PST)
Received: from localhost.localdomain ([103.178.205.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm46421688c88.9.2026.11.16.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:11:58 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: kbusch@kernel.org
Cc: hare@kernel.org,
	hare@suse.de,
	hch@lst.de,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sreekuttan2156239@gmail.com
Subject: Re: [PATCH v4] nvmet: clean up DH group state on initialization failure
Date: Mon, 16 Nov 2026 16:11:35 +0000
Message-ID: <20261116161135.2690-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179484220897.249619.16009819575182400523.b4-ty@kernel.org>
References: <179484220897.249619.16009819575182400523.b4-ty@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081200_344739_3A5FE569 
X-CRM114-Status: UNSURE (   5.73  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thanks for applying the patch!

Best regards,
Sreeraj

