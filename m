Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A4DC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7BqcxOiBncbWbb00d8kbjXH2HBy9dF17WHfCcK75YE=; b=dsDvt7j0zU7Sbj
	jgz/DzZDPRdJLeDb82zlYAL3EEU9/B0xVxX+JmhNvPMfHxyNoS19eKRdL8Wi/CwMJBU2ZQMFDk4pf
	b0aVdoDp/v/kpx39I4AvuCDhKER2otIIXdAFpl5W/adBJSlA5vUuW6980jpPsScDxF18RRsh4z1Sh
	Fi65JcIxi9SiHTpa8yCXhMgoAX/+Pvc51G1wksNO6PznLTrnIel9BINPrzSh++mclIPTVjnLSPtpp
	sdUG2HHVc3fGZ5f7+AEGGi5zlfXayV5HpzQ7fz42ioFQkFhvb58L/HuESYsVWIZM1YMy2+VmWscfl
	dfRBnJDcOkavaj0DIMfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuie7-0014uh-SG; Fri, 27 May 2022 22:41:27 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuie1-0014uC-Kz
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 22:41:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=o7BqcxOiBncbWbb00d8kbjXH2HBy9dF17WHfCcK75YE=; b=EAbzHprt/T+zp9x4cktS1Vebkz
	acGerWRT8JwrK+2uOMsK1Ug+v3jDk3VFA3oGyBrAB5tnJc982LKNjrUc7OaItvm44nNV0u44SRokZ
	a3aMc6P6g3Dcnm/C7JZh3H+ypL4Lq77HricOS8CTumdAFqX1Aw+ck4k9NDPBUvo/JUXfo2O48sjlZ
	B6VODvxwB+jUS8ODQNaeHmeBG7xIM6MOYhPpYhO4MWHp61N4kl2PD/BEUStcacj0MPalPUobpAs4k
	8i9nGqdGEyMJNsRptj6r3IEkDWVRoZ20dgOwLKAA1gwwJGWRT+40bKQkdd59LzJPcXRx1hqlcOwcY
	/4Z0kVGg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1nuidw-009AgX-Kv; Fri, 27 May 2022 16:41:18 -0600
Message-ID: <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
Date: Fri, 27 May 2022 16:41:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220527190307.GG2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_154121_740599_96363656 
X-CRM114-Status: GOOD (  20.74  )
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



On 2022-05-27 13:03, Jason Gunthorpe wrote:
> On Fri, May 27, 2022 at 09:35:07AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-05-27 06:55, Jason Gunthorpe wrote:
>>> On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
>>>> +static void pci_p2pdma_unmap_mappings(void *data)
>>>> +{
>>>> +	struct pci_dev *pdev = data;
>>>> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
>>>> +
>>>> +	/* Ensure no new pages can be allocated in mappings */
>>>> +	p2pdma->active = false;
>>>> +	synchronize_rcu();
>>>> +
>>>> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
>>>> +
>>>> +	/*
>>>> +	 * On some architectures, TLB flushes are done with call_rcu()
>>>> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
>>>> +	 * before freeing them.
>>>> +	 */
>>>> +	synchronize_rcu();
>>>> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
>>>
>>> With the series from Felix getting close this should get updated to
>>> not set pte_devmap and use proper natural refcounting without any of
>>> this stuff.
>>
>> Can you send a link? I'm not sure what you are referring to.
> 
> IIRC this is the last part:
> 
> https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/
> 
> And the earlier bit with Christoph's pieces looks like it might get
> merged to v5.19..
> 
> The general idea is once pte_devmap is not set then all the
> refcounting works the way it should. This is what all new ZONE_DEVICE
> users should do..

Ok, I don't actually follow how those patches relate to this.

Based on your description I guess I don't need to set PFN_DEV and
perhaps not use vmf_insert_mixed()? And then just use vm_normal_page()?

But the refcounting of the pages seemed like it was already sane to me,
unless you mean that the code no longer has to synchronize_rcu() before
returning the pages... that would be spectacular and clean things up a
lot (plus fix an annoying issue where if you use then free all the
memory you can't allocate new memory for an indeterminate amount of time).

Logan

