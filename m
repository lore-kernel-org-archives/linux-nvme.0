Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A90FCC048
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2026 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KP67p1NSYqM6ZCSNa4TuYu4+6IIAoh022RAVK5yTzZ8=; b=VlI/0jCTZw/MiZG4U9CkmbA2RN
	1CDQp/vUSK8717TuBT+3E9yDLOMIXPXELOYB6lCPM0lC1+W42QmUwxau6LARoKWYm977yLprX3Zth
	TquscmyNQ14W2mWkVsE/f/m6O9AteJje0ZYdwJtGyLy1UDl4aCyb5nb6dN0Wa/kTmu0RPbT6PC2QK
	EVSmOn/wmHTWnqE1hiwyJpvefjlHoywMkZgk4XECnSLSPcvNAb7He3vdxDFwMyUSAlxHtgdyFMdS9
	uzyyTjvGV2mSjtO1FDavZbWfJ6LEMiUrbjS6d7cgggM2VQkDjiuOdh/cnhII+E+H+wVa3BBKA8PLZ
	DbP9XoZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyZMm-00000004IUO-0Eti;
	Fri, 06 Mar 2026 17:53:36 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyZMk-00000004IU5-2lPV
	for linux-nvme@lists.infradead.org;
	Fri, 06 Mar 2026 17:53:35 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-503347dea84so100331941cf.3
        for <linux-nvme@lists.infradead.org>; Fri, 06 Mar 2026 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772819613; x=1773424413; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP67p1NSYqM6ZCSNa4TuYu4+6IIAoh022RAVK5yTzZ8=;
        b=ax53j1CyEQFxHH8xM8VVq+MbinyiOunu+mLhldDz3ujnlIx9AQqbh+takOTdthHHwK
         /Huo/zo34Fs49/Yc7JuPyilAONxrWPBQph/v9Ohxgvu3Ct4SL4XUkHXTqLHwoKefvLKu
         SaN/nwrKlzFiWkWmed4mpqwgi0hGSyXWd7PEN/YeoIhj2K279MqMLsiIev5QQHJbuYIc
         vGGhrp0FBGsARUQRRWLnYVSl4xw0AobYktFQvmxcgVDkxOcLxVRCk3Pv+xG9ohUNQz+R
         WVAzCDeoJxAEpUL3WmXKLahAb0rwjyMfPKFjlDGGHNbQa2DNa8SB7U/3R3R9X/0QmFqD
         FEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772819613; x=1773424413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP67p1NSYqM6ZCSNa4TuYu4+6IIAoh022RAVK5yTzZ8=;
        b=AG4Batu2Ph4ci1cMVg6hLEARx7D8ORY8ohYSBfzZrjpVxpOJnEfoojLachH3lowO0C
         dxiA5E/l8hnBgIStsfIC2tUS9ZqG5SrRokUDQtZXLweB/Grncan63Qoj8fbkgO9ZHLB3
         bdH/XLkEr+AhTbf9tNd+Jyu4kiF+G/FUMEGR5+3d/WrtgiyoWeVU7l8oKGEc2pDdSw37
         FjjHCZ5DYM7uNpECuCMuGlDthLdWAo7X1YX4kwOw8BqGuUrChqZ6zbW6gi3uVrQZdGxD
         CMKZQ5t8SIcMydpePpk9Xl8khEekDilsIf1m1ALUG2pmGQO226A1ommdpvdwS7Z8x7u7
         pBZw==
X-Gm-Message-State: AOJu0Yx5Wtzj8tt9xu4q18M2j/cjb//rfv7CQFCFumBLkTx9Bici+8e+
	ZL6+wySOR/QMJAkiwPSVl6QSuoJNtDvmeOSKHox6w0dDYMjSWAgcGJ2T
X-Gm-Gg: ATEYQzwVbaT8DvxWWcfmpfdJ+jAYmGw+j+rfBPk6nqDXfuyXeq/v3ITbuVwnPOEd+Vh
	XnuBrBFG9wNQ+yc27GOUcNYiOUzrGlgSCd+f9/ubkK3UvhSRfnbvaFOY01HIWxpKcPXGLt192gu
	b438iu6PPeT/oF6gBYTrIcdxVdXbLqsBFGUaj6ygUOo9aI0bsD/mhNBZ6bC5XV5rozRmv3e6ydJ
	58Z+TgamzoDszqzjD3XJtlaV1i0sUXE1HgO4ydRcqjc9c6Wa2BgxUsilWc5nLlTq5i5vihg8XF2
	z96wAuoGITMq/DmV+0S7jtU0Eopn+rFPRjW6ZHlddAJ6FjQvB+SwtsTrUJjXTpv7u3QivXIJR+e
	0HECt+JuEFb6boOw8nDngv+9NPJljojCmAUFIlL02ljh2x4L/4o/dMm8OzgFP3gYiVJ6Xu0bpIr
	/zYE9hkmkVXGcgx42gTJU3cPGI9xlr2pTVkN/NI70=
X-Received: by 2002:a05:622a:1914:b0:4ee:1e82:e3f4 with SMTP id d75a77b69052e-508f499f5f0mr40813091cf.64.1772819613021;
        Fri, 06 Mar 2026 09:53:33 -0800 (PST)
Received: from [10.69.74.8] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f66da78asm18026411cf.31.2026.03.06.09.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 09:53:32 -0800 (PST)
Message-ID: <ab537961-2ff3-44b7-aeaa-4df0a86333d7@gmail.com>
Date: Fri, 6 Mar 2026 09:53:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work
 cancel_work_sync()
To: Jaskaran Singh <jsingh@cloudlinux.com>, stable@vger.kernel.org,
 james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, "justin.tee@broadcom.com"
 <justin.tee@broadcom.com>
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20260223172241.291649-1-jsingh@cloudlinux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_095334_726129_67C8C963 
X-CRM114-Status: UNSURE (   4.04  )
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

For this patch set,

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin


