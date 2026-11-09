Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D14606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M82x9XGf;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=HvrYJGPH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6otXJ8lIDv4F0yh10IfYlKI2Iwg38oKsHts05bkX0bk=; b=M82x9XGf55GO1liZDiWxqxKdwi
	GuDjt2PpugIdzWEjV3WFON1n2cJrp6+YUoQbmDhz2BAEzrFh60eyc3xLvCDjYCZBF9Y8C1/Ri7+6j
	f8ns3TpaDRrzweXn754bod3vByCChcRSLbTR4jNkoA10pnwJSDCIVz/fEq2EWARO/OmiOnnywcogz
	xoBvwDu2yx4ESTOFe1/fMZ5I4dot2DH3oMCliuGkXPKbM+6fwK/t/b0m/mVQDnR1VXZFwh0Uv3k0F
	63cqjmD5LoFpji5Zyb3r5azfYuWJv7Z27fvB50ZXBWT0sDJmr5cm4zqbSyYpuO2Buod1mSYeVEYQl
	mUqr3v3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQV6T-00000001Ygy-3Kbv;
	Mon, 09 Nov 2026 19:32:29 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQV6Q-00000001Yge-3jHV
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:32:28 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2471415eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794252745; x=1794857545; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6otXJ8lIDv4F0yh10IfYlKI2Iwg38oKsHts05bkX0bk=;
        b=HvrYJGPHhmRHZ5Eno9JuUes/szvNg9x8jfGtZ+n0842fwSbB/0cO1/HrkZoJbf4sgD
         1LizI/rJBAl4wTyPbaK6jI7qYJKz8ierM0Hb1Js5GY5XBWNEpa2h+nFxG511RtC3t3Ds
         j1jLsYl5HfR6W3iPxTWtlP3Y5sAFipfraGHnwK/6mODegLP1zgXpWHNfqgh7oDglmv8H
         1HP275frTVEEuP/pHjGchmAQtBV/VsjeMTOyKHnm1u7y49mjWPWhj7TU1dn99WXjLdHe
         XfHnS3uCukkyyu0K/AUTOCzipOcw+Me6TOrG1fJyTyN6ld2yI5vFX29d1Xp24kBSoOkq
         ihRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794252745; x=1794857545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6otXJ8lIDv4F0yh10IfYlKI2Iwg38oKsHts05bkX0bk=;
        b=dFvYi2XY+OGEFdSOB7n8eY9ZJxrvRUEZuN/KHRrMD0a8Gpf9OELlB4eNbCcG+5XGdh
         aHubc9uR9DGD3XI+Cg0gfRoYqkdStDHIKhggNNbzolERgGmGkxFSkx2LoUa3hA/PMuuw
         0CMSLk5joZXjsTEhWU/ZKhKanxCEwnjsYZvFuuT8t0XnlmtwfJ+/WbSSHjciFMdLU6b3
         LSuDDNJ/Db/3D/cMWgoFNdj1qUKLGiRrEK8Zlj8n8c9MUn4P1Js9VRVAUBT5pFiVGAa8
         eOSqMktz2GgBxkfdjev9geMTXW97r3pLlDROB/IpI6XLHhGZRBJ817bcda2xkQzDxYdS
         cLig==
X-Forwarded-Encrypted: i=1; AL+hErGHQJr8iCkBH3lOq932p6wy0O/bgwzjWXCKN0DFL64xDwpDRvYr15JEdDlO04p7Dfvw0dB/AxHx0GZp@lists.infradead.org
X-Gm-Message-State: APuU4Z8dDGxljbjnyFHy018YA+Kp6bIBO2IxfHxJbJ2No5CNJXIJZulN
	wK0BZZg1CTBUvhL0B+HZWZutSg2TNWcXwLC7gRZiZCau+Qa6BwF+oQ4zN1bYPntXP1c=
X-Gm-Gg: AYBFou0UTgQdfybcjrtopLPU3L3MY0HX+bbrfGcedCLj75K9kzJpZBAygVedtCgvtSG
	agIuFkG2JVGd1lkivukGp4IiEKlPV6Rombv44C7zzRH7p+jkygbybtQSyYinN2P2XupG7N34my+
	/E0D72K94T+KX1NSx9sylIWxvzuElzmye6lqMVYiKcd7CnILnxjjG0vzs4bbS4WdxS+GHLP6nsT
	/9oMFf3EVodIO6//DVueVRYWWzA74jZ6LV6JSHR346Y/VvM2npHUiGQHkbN55k9v5G9c8jYZtiN
	4UUGH76zLDaHUQb4yRqIMRVcbDK/F0DtJBtGUXLTi3zwKOugVMxe8WdiGTGj6dMQ/evVDS8WGYp
	kpQuqYaA8o0d/2d0xE4vktnNAYPxalmFTLZjXOmIa6PeRPEtq0brORRRWSOS1uu8KLhhx/aRUFD
	QBvSkV/QB/PjfcLI7rTKATWzAXT8XACZ1/q+AWbAJ1STm69G8imSyr0hThnxyQNtdBM91QH5qoR
	rhZG9Jz376JGUQEsUHKgqMyrIfKLitBB+IpD2ggDDyIxNiLjrMD0YDOGpkBZzIEmQPSAf/qFWEm
	i804WfvZzaxk2vfCChdcOB4HIMyV1xjGx2aJ5V2P6gzN1wQHcpgap+2gvtf8ljfK+Ug8rQ==
X-Received: by 2002:a05:693c:415b:20b0:36f:29bf:4326 with SMTP id 5a478bee46e88-37519aba60cmr378235eec.0.1794252745062;
        Mon, 09 Nov 2026 11:32:25 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm451241eec.3.2026.11.09.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:32:24 -0800 (PST)
Date: Mon, 9 Nov 2026 11:32:23 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: zhang san <shunsheng1218@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: Question: NVMe AER completion delivery during controller removal
Message-ID: <20261109193223.GB765534-mkhalfella@purestorage.com>
References: <CAGTEBTa9dGn8TjKxRPsfeCFiRYAt-cGMAp-XSLBS86SHB6FJ_A@mail.gmail.com>
 <20261109190854.GA765534-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109190854.GA765534-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_113226_931279_82F52977 
X-CRM114-Status: GOOD (  26.54  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-11-09 11:08:54 -0800, Mohamed Khalfella wrote:
> On Wed 2026-11-04 12:50:42 +0800, zhang san wrote:
> > Hello,
> > 
> > We are seeking clarification about asynchronous event request (AER)
> > completion behavior during NVMe controller removal, before treating an
> > observed test failure as a production-reachable driver bug.
> > 
> > Our source analysis suggests a possible lifetime race between the AEN
> > completion path, which can requeue nvme_async_event_work, and the
> > controller removal path. We observed KASAN use-after-free in an
> > emulated environment on Linux v7.4-rc1 (6628e7d4c6b2).
> 
> 
> My reading of the code suggests this can happen. nvme_stop_ctrl()
> flushes async_event_work, but the admin queue can still deliver an AER
> completion afterwards, either from the admin queue interrupt handler or
> from the final admin CQ poll in nvme_dev_disable():
> 
> nvme_remove() ->
>   nvme_dev_disable() ->
>     nvme_poll_irqdisable(&dev->queues[0]) ->
>       nvme_poll_cq() ->
>         nvme_handle_cqe() ->
>           nvme_complete_async_event() ->
> 	    queue_work(nvme_wq, &ctrl->async_event_work);
> 
> 
> Nothing flushes async_event_work after that, so the work can run after
> nvme_uninit_ctrl() drops the last reference and the nvme_dev is freed.
> 
> > 
> > However, our test induced an ERROR AEN through an out-of-specification
> > MMIO doorbell write while the device was being removed. This
> > deliberately synthetic trigger does not establish that a compliant
> > controller would generate the same completion.
> 
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3909,20 +3909,21 @@ static void nvme_remove(struct pci_dev *pdev)
> 
>         if (!pci_device_is_present(pdev)) {
>                 nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>                 nvme_dev_disable(dev, true);
>         }
> 
>         flush_work(&dev->ctrl.reset_work);
>         nvme_stop_ctrl(&dev->ctrl);
>         nvme_remove_namespaces(&dev->ctrl);
>         nvme_dev_disable(dev, true);
> +       flush_work(&dev->ctrl.async_event_work);
>         nvme_free_host_mem(dev);
>         nvme_dev_remove_admin(dev);
>         nvme_dbbuf_dma_free(dev);
>         nvme_free_queues(dev, 0);
>         mempool_destroy(dev->dmavec_mempool);
>         nvme_release_descriptor_pools(dev);
>         nvme_dev_unmap(dev);
>         nvme_uninit_ctrl(&dev->ctrl);
>  }
> 
> Since you are able to reproduce this issue reliabely, how about you try
> the diff above and see if it fixes the issue.

Looks like it has been already fixed in [1].

1- https://lore.kernel.org/all/20261105114149.970315-1-shunsheng1218@gmail.com/


> 
> > 
> > Our main question is: can a specification-compliant controller deliver
> > a completion for a previously submitted AER during the interval in
> > which the host is disabling the controller and tearing down the admin
> > queue, or must such completions be quiesced before disable completes?
> > We would also welcome guidance on the exact point after which the host
> > may safely assume that no further AER completions can be delivered.
> 
> If the above diff fixes the issue for you, then I think this is a driver
> bug.

