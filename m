Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE178C77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCdmusHQw1hma0DaJQ7ENIAUI3p068UeBvmYPlA/yQM=; b=nqHfPhCxnkRdaNFOwZ5UIx9tpJ
	CBwhw7kYpl8A6G14Bn4H+B+Wl7P716nHuurrEHvWEKclvbzzopL3Pcqv42nr2CS6GL2jGAw2Q6eOh
	XcmnLdrTPtsgRuahThHAhg/IMsZNZvqx7/Me/v743el7F+qGlmj6xAZ9rktnDJKP2xvPCsWYquCT9
	Mu1edsZIdDjbrSqQMgEVl7RtqPMdO3rzcYfCdYlA/9gwJD9iGSMq34bDe8+pH+9HYbmLxNgpLYGz+
	992020AEKwHw88JNBTEYnWQuzSEGXvgWwIszR8VupkexLCHkMzPbddKyf/DoygmN7cRk3N5FEY3+J
	NXtilQ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poMhK-00Fw0p-2P;
	Mon, 17 Apr 2023 11:07:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poMhE-00FvzV-2a
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 11:07:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ADC3261118;
	Mon, 17 Apr 2023 11:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E53C433EF;
	Mon, 17 Apr 2023 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681729615;
	bh=JLYth4eiAIJjUtddTrSDhGlOPDaY+mywpyZByGmFQdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fTVTL6rfOgeBsX0kzh3bI51WUeL/JH3cPYAJIKm/TLeA9jX3PY7sUO0TGGMnEGUcH
	 WWSdXGXv//FqZFkWM+mOxjanlS4t6lN5yWbK4XFalRNwlD3mjRbNYSTxBdh0ZMKUYm
	 Lx2FypMfyDuqPqEnndcsBPDMVBoHOGnHNjpWTL7BfmjPQssCgf4ClHNu5pMmd7//0G
	 R8oCN+LcpTJA2vVhH8sn2JX8Xd9i/DZLH5TIMTKWm6orWv3eFeNa7/o+1JYNPCfgo+
	 wcydkTPkiWNF9RMEvk9ZG98aVVOGpkRi8RvNhHWjSufWakcJDcSyZXFFl6G2py5vOt
	 kVzm1Pfgwrz5Q==
Message-ID: <76432336-a866-0fa5-f42d-aa1f64945214@kernel.org>
Date: Mon, 17 Apr 2023 20:06:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: WTF is going on with the nvme-cli build
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
References: <ZDemsiJi5vXd6aia@infradead.org>
 <4jstzssirve7hiaimj6fm52rftqadwo2tmnjx62zq7lzkrjkfw@ooh4zluxlrrd>
 <2a464237-975a-bfaf-ef2f-15ffd45b4d8a@kernel.org>
 <sqrbip3dafgf4cnmmdziect6vem2msocsxqcqmnvyrlkartomj@ilwk43vyl53s>
 <c70e194b-ed19-7d0e-5976-477cfa74a716@kernel.org>
 <rjoeveo4f64f6hwdu65weljwbeceoj4h6eriiborxtnvfzmeqo@l3t5uh5s24rq>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <rjoeveo4f64f6hwdu65weljwbeceoj4h6eriiborxtnvfzmeqo@l3t5uh5s24rq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_040656_875061_871D529E 
X-CRM114-Status: GOOD (  19.28  )
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

On 4/17/23 18:14, Daniel Wagner wrote:
> On Mon, Apr 17, 2023 at 06:02:24PM +0900, Damien Le Moal wrote:
>> Not sure why as in Fedora, pkg-config is a shim layer on top of pkgconf provided
>> by pkgconf-pkg-config package. But I cannot uninstall pkgconf-pkg-config as it
>> is used by gnome-shell.
> 
> Didn't know about this new implementation of pkg-config. I found some explenation
> here:
> 
> https://fedoraproject.org/wiki/Changes/pkgconf_as_system_pkg-config_implementation
> 
>> Looks like something is broken in Fedora Not sure what as
>> /usr/lib64/pkgconfig/json-c.pc is perfectly fine, pointing at /usr/include/json-c.
>>
>> But I would still say that it is probably time to update to pkgconf :)
> 
> FWIW, you can specify which pkg-config implementation meson should use via the cross
> ini file. For example here is the one for using clang instead of gcc:
> 
>   [binaries]
>   c = 'clang'
>   cpp = 'clang++'
>   strip = 'strip'
>   pkgconfig = 'pkg-config'
> 
> https://mesonbuild.com/Cross-compilation.html

Replacing 'pkg-config' with 'pkgconf' and reconfiguring+compile still gives the
same error. But I think I found the issue: I had a
/usr/local/lib64/pkgconfig/json-c.pc file pointing at /usr/local/include/json-c.
Not sure how that garbage ended up there. Removing this file and compilation is ok.
My apologies for the noise.

