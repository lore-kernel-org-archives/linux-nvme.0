Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEA1C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O0XE5SJwfNL9pRHWcxhiLN1w42LUU8SzANBPOGnMYmU=; b=VPG+n4FdOBvZn67Sp5U/TBaEz0
	CipBezfYzXTaZL5B8gTXr1KX8oHLYY3Sypax2M/WdhU/nhtVbD978TzzfmTOyZr7Gl6wKRMU6Lplj
	J/etmIJXvRl8wlmg9tr3I0N2+1zemhTS4XqoNuYLt9mECcjWB8luEDxMAcXWvv7LJ/Zp+Wypy8QaY
	qM0xotaAzMg5iJUJD/FNizjJ9DNLoGt+3z7O3KawSOkClufuH3iMc9xlQxGU1G1ieY2wEPS5YbUDF
	BZIaqJuU7DRgyVYoAUu5NwnjKe8cyza9ESJnJOKBXNPH9zpLexyWqSqHDkzLGH2KDUl6Smnfep1vm
	kEw2cUuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u463x-00000000HfQ-0OXT;
	Sun, 13 Apr 2025 22:44:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u463v-00000000HfC-0naj
	for linux-nvme@bombadil.infradead.org;
	Sun, 13 Apr 2025 22:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=O0XE5SJwfNL9pRHWcxhiLN1w42LUU8SzANBPOGnMYmU=; b=K+q0Ym/a3cffUe3WUAJQtfdKnz
	+3+NtnzEyPdYrg4J7ylqcPfkCMFpkavCHjUMmnJ9z16VNzIGnRTQsbOSqFnHJIXg+2QLESlGv+nzk
	mExq82gTDD+pgq9z13BGZ+S7JXPi5UIYdMysjVvz8c8+UZ0s76RKHUTiwEpITZekS8ixVgPNpoyWS
	11gujzMMHCvbXJ80hzhoYLCWBidWuhAvU4/qbL2vbCKjj6B5yh+ws1HSYOrQogmUlwMUHcT/8n8E0
	3gi1YKE241pfGVBXcBmU4rW8F6R8+njnTNFgdQCQsJgWJb2SL87rZnh4yNNJ3dtQ/TickgdQykFBP
	2gpw8URA==;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u463r-00000009b7h-23jK
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 22:44:25 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so2300720f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 15:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584261; x=1745189061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0XE5SJwfNL9pRHWcxhiLN1w42LUU8SzANBPOGnMYmU=;
        b=hEN/+q2ypaPoILroTAPTrNTOpDgo4RyyW0v/H99Jy6gItvExKQuIUB3AjSKLSRN0CD
         s780gRC/Ii+Ij/RhNDuWnEsn+WOM6eE2WsyhKstVoqOf3XdA/ecEDdWNF48YpmwQXLPl
         Ng/RpWCcvnvYsnKWZHTNxREmq0HbPRoKcZaA2qc4rfZZGtItuWsibuZwwNxJE/AXiXRy
         rFEDEXhp3IOUpLtzdees5V8Thkc+1cub4l1V1VcEdlmWV4oakO0BNTnV2JyHXB6YTxfo
         5FziGsNoWpnHD4R9xg3WDIbgsD2YuBs78oUVhjsAWUKATGgCvoJDMeB/mqIUsn2V+0Hn
         3G+w==
X-Forwarded-Encrypted: i=1; AJvYcCUgbRuFQW03XkTrLFNbBFV1BqVFnP+6dZ5rak5vHak8/X4PRI/WShG4+BtAq8MCKRgq9uT0wYw8tOmM@lists.infradead.org
X-Gm-Message-State: AOJu0YwF9vTT5jG/XR0Dz00KFmzqC1cOo1oIqL1Q8VjuA3iXOmoYvslL
	mzkmXuZ2h53kW4AVQ7Hm760tdmbDHHmusDQT1thIr9HACOhpUReWBkcNNA==
X-Gm-Gg: ASbGncvxf+pEJZPd2octAVFfjCx8VeZa/DYk9QKxb51iX1VBMVsL21huAcdlrU/YHCO
	jnOItFRbt/QgbyOEr+L5n0IVUvhUfAnzglxelKQERJTQN+N4bQJV9q+5CKkZ9lGYWR7csCSGxW1
	DTONQMuIjwKuYC+6Amt+mZCcmDkXOdwNFhKWAOjkcvM/WwlZhhMOPmdYvPH38mSkI4KRq56fOzF
	cBfTT6e3JYHq1oLIzhiuzDHiSb/1enR9Ja37iC1ZCcv6tzenR9r1up5zDoS6jr2rZN+H0ssR9/n
	X6lFloKYEn1vhkbLZgornXlgbV31jH8fhm5+bKRbW+B1S1CiZkiZikrXsLr06E8Qvq+BDTfJ
X-Google-Smtp-Source: AGHT+IE3B9lrGGkYGV8343GHs1EPScwz+T7flkihCxbn6PBuhUWh2H5PvMFyOVR/RvnDz2nzl6nOUQ==
X-Received: by 2002:a05:6000:1863:b0:39c:30d8:f104 with SMTP id ffacd0b85a97d-39ea51d356amr7120783f8f.6.1744584260815;
        Sun, 13 Apr 2025 15:44:20 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm157031905e9.15.2025.04.13.15.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 15:44:20 -0700 (PDT)
Message-ID: <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
Date: Mon, 14 Apr 2025 01:44:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, linux-nvme@lists.infradead.org,
 mlombard@bsdbackstore.eu, zhang.guanghui@cestc.cn, loberman@redhat.com
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250404082801.1614252-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_234423_905110_EF520FC2 
X-CRM114-Status: GOOD (  12.55  )
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



On 04/04/2025 11:28, Maurizio Lombardi wrote:
> There is a potential race condition that can occur if
> the target closes the socket while the host is in the CONNECTING state.
>
> If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
> function is invoked. However, nvme_tcp_error_recovery() is unable
> to transition the controller state to NVME_CTRL_RESETTING because
> the controller is still in the CONNECTING state. As a result, error
> recovery is bypassed, and the controller incorrectly transitions
> to the LIVE state with closed sockets.

I think that the issue is that the controller moves to LIVE state - it 
shouldn't.
However its not clear where this happens.

>
> Subsequent attempts by the host to communicate with the target
> will result in an infinite loop.
>
> Fix the bug by initiating the error recovery process to correctly
> handle the disconnection in case we missed this event
> while transitioning from CONNECTING to LIVE.

The problem is in the initial connect - here there is no error recovery
and we want to propagate the error to the user.

