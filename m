Return-Path: <SRS0=Wzp6=IS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B81C433C1
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Mar 2021 22:37:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA0F61933
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Mar 2021 22:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA0F61933
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bombadil.infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BBYgkx2ZE2IyG5kve266iqFfLedNg10LoP/sAwffxiM=; b=C+zhy7CsfW45AWW+7f9nF75q6
	s7ugdj9JVM7coxPfugroy3PcL0MixPofwnXkYS5nU9z1mpZn/nchEZgO2EgbzJP1DDZGdUR51C+2j
	rs5b7vmcPEDw7wtMGq0Prnf3P9HrNau/oTHd+AQ9DtrDLnD5sulb5F3ypTGn40fe05AmCL9ZVokJq
	UGU7sIZ0iAJPL7enm5asbFUGzomWjtTmUrX1JR9m8YPJ0XRZS77lxPWJXVg3xsyatHWaMDyk3KQib
	YdLPK+TFwXBupI3zX79bnQ7ULWJC+S+/TS0b/dzB5mPj5Culmxmog6iE7gncKECDsp2XWEpojzL0r
	9jLuv4y3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNkDi-009OO3-0H; Sat, 20 Mar 2021 22:37:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNkDg-009ONv-8L
 for linux-nvme@lists.infradead.org; Sat, 20 Mar 2021 22:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
 References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Fo07rwgSbncNv9g8juqCxf2tFviU98VyJSW5pomvlzw=; b=FLd2MDmDl3qTCl/TN5j9lyUFwu
 budKs1q8Mnpuxs7l4VfdmMd70w0JL+jq3ncRScA0ZD8WO9zLkbX35145VyLyxmfZPPVb2JOWPIB5l
 z547aBNGLIk4sg4MYYG8FfNKIpbxZTfMJiBYErCACWfOZRvmY7X0nUtv44qzVXQoE4Ny0l4mtTPgn
 ZEmnE464VYJyN2VCSU9T9BJdNgQfpwtmTcgPPXA2iuNhjEPB5NntQJv81Wyqe8bIZvwhoL14w+/T9
 jhSYwQc3uKDDWNoKTEAmVBYMFiRDKz7v8lSs3XKwshRNYs8GrlG0hn3dhWLKZ7bImctMQyjPpBU//
 qXi6gc1g==;
Received: from rdunlap (helo=localhost)
 by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lNkDc-0024Zw-1x; Sat, 20 Mar 2021 22:37:17 +0000
Date: Sat, 20 Mar 2021 15:37:16 -0700 (PDT)
From: Randy Dunlap <rdunlap@bombadil.infradead.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc: james.smart@broadcom.com, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: Few trivial spelling fixes
In-Reply-To: <20210320203002.13902-1-unixbhaskar@gmail.com>
Message-ID: <33e8935b-83f8-3384-dbdc-717988c59faa@bombadil.infradead.org>
References: <20210320203002.13902-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_153716_124503_F91FB77D 
X-CRM114-Status: GOOD (  21.97  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/boundarys/boundaries/ ..... two different places
> s/assocated/associated/
> s/compeletion/completion/
> s/tranferred/transferred/
> s/subsytem/subsystem/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> include/linux/nvme-fc-driver.h | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 2a38f2b477a5..8624b0c6aace 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -441,7 +441,7 @@ struct nvme_fc_remote_port {
>  * @dma_boundary:  indicates the dma address boundary where dma mappings
>  *       will be split across.
>  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
> - *       4Gig address boundarys
> + *       4Gig address boundaries
>  *
>  * @local_priv_sz: The LLDD sets this field to the amount of additional
>  *       memory that it would like fc nvme layer to allocate on the LLDD's
> @@ -608,7 +608,7 @@ enum {
>  *
>  * Structure used between LLDD and nvmet-fc layer to represent the exchange
>  * context for a FC-NVME FCP I/O operation (e.g. a nvme sqe, the sqe-related
> - * memory transfers, and its assocated cqe transfer).
> + * memory transfers, and its associated cqe transfer).
>  *
>  * The structure is allocated by the LLDD whenever a FCP CMD IU is received
>  * from the FC link. The address of the structure is passed to the nvmet-fc
> @@ -631,7 +631,7 @@ enum {
>  *   When the structure is used for an FCP target operation, the nvmet-fc
>  *     layer will fully set the fields in order to specify the scattergather
>  *     list, the transfer length, as well as the done routine to be called
> - *     upon compeletion of the operation.  The nvmet-fc layer will also set a
> + *     upon completion of the operation.  The nvmet-fc layer will also set a
>  *     private pointer for its own use in the done routine.
>  *
>  * Values set by the NVMET-FC layer prior to calling the LLDD fcp_op
> @@ -640,7 +640,7 @@ enum {
>  * @hwqid:    Specifies the hw queue index (0..N-1, where N is the
>  *            max_hw_queues value from the LLD's nvmet_fc_target_template)
>  *            that the operation is to use.
> - * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be tranferred.
> + * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be transferred.
>  *            Field is only valid on WRITEDATA, READDATA, or READDATA_RSP ops.
>  * @timeout:  amount of time, in seconds, to wait for a response from the NVME
>  *            host. A value of 0 is an infinite wait.
> @@ -718,7 +718,7 @@ enum {
>  *
>  * Fields with static values for the port. Initialized by the
>  * port_info struct supplied to the registration call.
> - * @port_num:  NVME-FC transport subsytem port number
> + * @port_num:  NVME-FC transport subsystem port number
>  * @node_name: FC WWNN for the port
>  * @port_name: FC WWPN for the port
>  * @private:   pointer to memory allocated alongside the local port
> @@ -919,7 +919,7 @@ struct nvmet_fc_target_port {
>  * @dma_boundary:  indicates the dma address boundary where dma mappings
>  *       will be split across.
>  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
> - *       4Gig address boundarys
> + *       4Gig address boundaries
>  *
>  * @target_features: The LLDD sets bits in this field to correspond to
>  *       optional features that are supported by the LLDD.
> --
> 2.26.2
>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
