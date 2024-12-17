Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0467BE7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=; b=BXMmH6ISRjAcOmun6EDMCjiN9V
	ZQqfZ0ZGZC+p3I23uboasL3kTLLPQ6I9ZCCF0kzPRw9iSRGOL/JtcMY/CZVgcOWqqBU10duba6F0Y
	LPfW5BAsDo+Jmuiedyc4PQVtnHbH3HWYyGWyH9dbvFai0P7HtWmkXeG1upMARfcZmNungwQ1sic6D
	MnLzSLyD+Ckc98a994RYWTh+WDlWZiVEpmlb5sQ+jtoUNJRtQOs7Vr0ETRBakzV+tN2H40buQhOm/
	J8MmTtWk0n7rjMzEPFnYIiMZthxIzUjdjL3Q6Bg82icBbgFw91LoXUmehN2eBpiDProGw0sjexRr9
	FgdEmDtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNY9B-0000000DfWd-3WR9;
	Tue, 17 Dec 2024 14:02:01 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNY98-0000000DfWH-3a9X
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 14:02:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A49831F394;
	Tue, 17 Dec 2024 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734444116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=noJgL6Kf9h2aAK9Ebrdi6WcNa5uuZn/eXUpUdJtLmT4RzWgn+f9Ri4wq/L8XICzAz7aYmo
	tOf56ZS9n8pGrCVtes4at04hUtaKkn7Ngu4qGsf5OsARfLHxxkZMAhR2lzsphHckdTN53a
	HJjyfZHJIh5Y3WMcG74u/728s2K98eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734444116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=b6yHKgUtCnuaysrKdVG2FWrua7iFm5a7okFMxXH8tdgGv8laxZpLweSPi5Ka4hcWUAEV4N
	PQlJvVcJKFkdqzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734444116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=noJgL6Kf9h2aAK9Ebrdi6WcNa5uuZn/eXUpUdJtLmT4RzWgn+f9Ri4wq/L8XICzAz7aYmo
	tOf56ZS9n8pGrCVtes4at04hUtaKkn7Ngu4qGsf5OsARfLHxxkZMAhR2lzsphHckdTN53a
	HJjyfZHJIh5Y3WMcG74u/728s2K98eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734444116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQI3phBxHp9FDQsecPAobL7xUUHXjQMx7H5vuSw8f4E=;
	b=b6yHKgUtCnuaysrKdVG2FWrua7iFm5a7okFMxXH8tdgGv8laxZpLweSPi5Ka4hcWUAEV4N
	PQlJvVcJKFkdqzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B58913A3C;
	Tue, 17 Dec 2024 14:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNzbH1SEYWfgBwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Dec 2024 14:01:56 +0000
Date: Tue, 17 Dec 2024 15:01:55 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
Message-ID: <bee71ac4-37bf-4182-ad7e-78efd9baff46@flourine.local>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
 <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_060159_037184_DE954E18 
X-CRM114-Status: GOOD (  18.90  )
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

On Tue, Dec 17, 2024 at 10:45:45AM +0100, Hannes Reinecke wrote:
> On 12/17/24 09:35, Daniel Wagner wrote:
> > On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
> > > > +	/*
> > > > +	 * It's either a kernel error or the host observed a connection
> > > > +	 * lost. In either case it's not possible communicate with the
> > > > +	 * controller and thus enter the error code path.
> > > > +	 */
> > > > +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
> > > >    		return status;
> > > >    	/*
> > > > 
> > > Hmm. Maybe checking for NVME_SC_DNR, too?
> > 
> > if no one complains I'll update the check to:
> > 
> > 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> > 	    status == NVME_SC_HOST_PATH_ERROR)
> > 		return status;
> > 
> > okay?
> 
> Which really cries out for a helper. But otherwise okay.

As far I remember, Christoph is not a big fan of single users of tiny
helper functions. Anyway, what about this:

+static bool nvme_num_queue_updated(status)
+{
+       /*
+        * It's either a kernel error or the host observed a connection
+        * lost. In either case it's not possible communicate with the
+        * controller and thus enter the error code path.
+        */
+
+       if (status < 0 || status & NVME_STATUS_DNR ||
+           status == NVME_SC_HOST_PATH_ERROR)
+               return false;
+
+       return true;
+}
+
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
        u32 q_count = (*count - 1) | ((*count - 1) << 16);
@@ -1701,13 +1716,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)

        status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
                        &result);
-       /*
-        * It's either a kernel error or the host observed a connection
-        * lost. In either case it's not possible communicate with the
-        * controller and thus enter the error code path.
-        */
-       if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
-           status == NVME_SC_HOST_PATH_ERROR)
+
+       if (!nvme_num_queue_updated(status))
                return status;

        /*

