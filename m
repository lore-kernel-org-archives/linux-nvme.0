Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B49C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 22 May 2022 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQtGOV8ehr9B0byuPgB/R0qAJIaG0/ZyE72cxpjHldY=; b=AlhJYsnuLmNr6hfkJw3EtEss+l
	gnqMeiis+moTER+I1NgCRM1N9gbPFf0rf1IW+Owuu/w/0R0FR3nQhbaXZVHIAb6nyhx5hE+aIF6PA
	ZRHXBvXieQs47Gp7TOEadjwPXFClXcsuS76CiLVHU0o9GY+iKuVuzy0B1m1oVsO9JjKGPAO8JCimm
	abyA4/7Is2D8QyVyt/AyzUut3r+HrhMaKiFav2T1lEtB8EjR4Wndav8f56o8G/FUV8YXmwmgvnbKU
	79ZbB2ENVZ817mRpu1Pr5EBdEpOB5EmWKbrviLYrEKQgFFo6djN/VshOAkXwZxXcDeZX2khcgKd5h
	sdX+LIjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nskCo-001F33-Hl; Sun, 22 May 2022 11:57:06 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nskCl-001F2c-6Z
 for linux-nvme@lists.infradead.org; Sun, 22 May 2022 11:57:04 +0000
Received: by mail-ej1-x629.google.com with SMTP id f9so23529100ejc.0
 for <linux-nvme@lists.infradead.org>; Sun, 22 May 2022 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DQtGOV8ehr9B0byuPgB/R0qAJIaG0/ZyE72cxpjHldY=;
 b=qG3Kocdsq2oYYGDEOFNTT93XeYI9iYcUWVQ/xcuqMlQWR+ZjOVjzShfb129BRCBeZA
 IbjnscCqLlyomggb5cyR9GpqqOBdpUuUo3+FbJYLbl0iiv4HCdnE6oUZAjMcMn8rI7k4
 0hiscQzwOz5MmXbxTMw0aR1wARxwwUQ1FuY3GMHNU3MYRkf2+RKVREPc8am7/wzdyl9t
 oIyX9zl9X57zupPpZORXrjsSN9N5PSh3n0Y67eW7PS38UKVmdPQe7ua4dEOBiXOcWWqU
 BGUgHNpBaUTmrppJ4h/Xnpqc8TBObkcgTfQfATGh0SAgYKROqWnr/m2p+Lv8tSSupBQG
 Eqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DQtGOV8ehr9B0byuPgB/R0qAJIaG0/ZyE72cxpjHldY=;
 b=gd3q/U0ewU/5s33c2GbgfflquVMpcjbI+RcDY2MFn04rAoiJt1CdxkerWVOssIq4DX
 VPpOF+2JDt33hsMhEvWVmjMDvoIpiRzvk2fTjDDTa53CRubYyZj/gU4z1XGCXV90n6rw
 kl4HTezHae2AoG8kCbrPuq5go0Xe49PdWKhmLmhlZoDVqCMhyfkBmyG7V+KTvodHEh4Y
 hwmwH/cxtvZgV+0W4yEoW269hppH1A1GwuFPZNAyAtGwbyTRomb2qBiV5OqV1KUpg/1M
 37iZ1HvyONITVo9IUpNJJike3LQFfLc1Y5VkU3PPFXtaMYsBfSeFAthQ1YmFQIUVmHSf
 WdpQ==
X-Gm-Message-State: AOAM533zvaqe+NsLQ5ibSRaONYsbLATe0AVVpDrjDvwtasoILw0kwEdV
 eVAaOFiC82oMIplZowmPjtA=
X-Google-Smtp-Source: ABdhPJyUp97Woq4Tojt0R/LZFMRQbE+AliJIsobK1w7h8qb86kKoEvaA54Id06XPIzhUaW1XPVm0Cw==
X-Received: by 2002:a17:907:7282:b0:6fa:9365:f922 with SMTP id
 dt2-20020a170907728200b006fa9365f922mr15297634ejc.262.1653220621612; 
 Sun, 22 May 2022 04:57:01 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
 by smtp.gmail.com with ESMTPSA id
 jo14-20020a170906f6ce00b006feb5cae5f0sm2338997ejb.132.2022.05.22.04.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 May 2022 04:57:01 -0700 (PDT)
Date: Sun, 22 May 2022 13:57:00 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-staging@lists.linux.dev,
 "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-sparse@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
Message-ID: <20220522115700.vg4hsytav74sy3x6@mail>
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
 <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
 <CAMuHMdVx7r-4TVV9uVJppT-7ZAriov01BUNk4ghU9Bs4uY28vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVx7r-4TVV9uVJppT-7ZAriov01BUNk4ghU9Bs4uY28vQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220522_045703_304863_98B64477 
X-CRM114-Status: GOOD (  12.75  )
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

On Fri, May 20, 2022 at 02:46:20PM +0200, Geert Uytterhoeven wrote:
> > The "(void)" makes sure there is no return value.
> > Which matters if the result of a function returning void is propagated
> > to another function returning void.
> 
> Which, FTR, sparse also doesn't like:
> 
>     error: return expression in void function


You should get this message only if the expression is itself not void.
For example:
	$ cat test.c
	extern void fun(void);
	
	static void ko(int *ptr)
	{
		return *ptr;
	}
	
	static void ok1(int *ptr)
	{
		return (void) *ptr;
	}
	
	static void ok2(int *ptr)
	{
		return fun();
	}
	$ sparse test.c
	test.c:5:16: error: return expression in void function

IOW, sparse warn only for the ko() but not for ok1() or ok2().

If you have a case whee it s not the case, please send me the
pre-processed file and I'll be glad to investigate.

Best regards,
-- Luc

