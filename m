Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A24BC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eHpG4SKViFI3rCvAabMYSgFfAwVWOdiVyyuNBRRo/k=; b=Kiv3sSU6o6Sq8N/jlA3qWQ3RL+
	2uPCt9KY1Cx77dp8JRX9EzY9F2gQrgIhFkYtLobhmiHv22PUmmACNWskY5rJ/HMZRZ2+1mOGia4De
	kdcbeLNaEwzjXxTiCjlk3dQtUxbkevD3ta/bDJA9Slr97IlnfsqLI8YjvfHxm2Bi7inkylCri9qZu
	7ygzj7JTZXSACGDxlEXhuwz++hTPlY/a7G/X6uXL7mbr8MtW/hIXzx8snFnwZIfiXKKmId0L+zEYu
	RzxEkFtYU1tAeY41k8ELR5JSr5Ys3dPobTS4ydRwjQrUFGM28XEo+HX9ZKEiGOdLPv3JUtamXbskM
	q5tYDkDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poKkp-00FS59-0t;
	Mon, 17 Apr 2023 09:02:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poKkm-00FS3r-2A
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 09:02:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CD7166101C;
	Mon, 17 Apr 2023 09:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA990C433EF;
	Mon, 17 Apr 2023 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681722147;
	bh=oDuYFBffavwlkx4WYyDmBA6eqHUI4e97LwZe4EkVA6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=beEtbP/j5oum5fZJGrXPGUcKSNElyyHkWEYOrYNExkXecYbHgOdA0mRl9jxdK0is5
	 GXYUYVzwgDJVoDJCGeKOH+mBgFMKpewWNUqnYR3DBMl3v339xMGf2uKO2EwncIQhp7
	 NVZnBv8bKZuDIp72iCTvzIaVQssMgKLPb1lT+WGt4FxNJDlNdq0ZIxwisBzcWKnjSg
	 WEODuOvQ/LCzWt5E/FeqZbDP2xNmXTsdxRs9x3o1hECnerDTl6wu5RcMtTjlez9lD7
	 B0padycL2lXAv60qCmLcjEiS4zUQguJ7uGvr22+IMbCE4jGe1L78qky+uVxTtDrVlx
	 ayanCPjOZ7WdA==
Message-ID: <c70e194b-ed19-7d0e-5976-477cfa74a716@kernel.org>
Date: Mon, 17 Apr 2023 18:02:24 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <sqrbip3dafgf4cnmmdziect6vem2msocsxqcqmnvyrlkartomj@ilwk43vyl53s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_020228_770942_D45CC250 
X-CRM114-Status: GOOD (  15.35  )
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

On 4/17/23 17:44, Daniel Wagner wrote:
> On Thu, Apr 13, 2023 at 07:49:42PM +0900, Damien Le Moal wrote:
>  All the time... And I do have the json development headers installed:
>>
>> /usr/include/json-c/json.h
>>
>> But the compile command does not add -I/usr/include/json-c: it uses the broken
>> default /usr/local/include/json-c. No normal distro install anything in
>> /usr/local...
>>
>> And that is despite the fact that meson setup says:
>>
>> Run-time dependency json-c found: YES 0.15
>>
>> Something is not right.
> 
> meson uses pkg-config (and cmake) to find all the dependency. I suspect the
> PKG_CONFIG_PATH contains /usr/local/lib/pkgconfig. Can you check the
> pkg-config configuration?

Yeah. The problem is there. pkgconf gives the correct path:

$ pkgconf --cflags json-c
-I/usr/include/json-c

But pkg-config is broken:

$ pkg-config  --cflags json-c
-I/usr/local/include/json-c

Not sure why as in Fedora, pkg-config is a shim layer on top of pkgconf provided
by pkgconf-pkg-config package. But I cannot uninstall pkgconf-pkg-config as it
is used by gnome-shell.

Looks like something is broken in Fedora Not sure what as
/usr/lib64/pkgconfig/json-c.pc is perfectly fine, pointing at /usr/include/json-c.

But I would still say that it is probably time to update to pkgconf :)


