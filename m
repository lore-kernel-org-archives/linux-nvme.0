From: kbusch@kernel.org (Keith Busch)
Date: Thu, 9 May 2019 10:37:27 -0600
Subject: [PATCH] nvme-cli: cleanup comments for telemetry log structure
In-Reply-To: <SN6PR04MB4527F16CCAA2E44830391E3A86330@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557416597-21777-1-git-send-email-akinobu.mita@gmail.com>
 <SN6PR04MB4527F16CCAA2E44830391E3A86330@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190509163726.GA9675@localhost.localdomain>

On Thu, May 09, 2019@04:38:03PM +0000, Chaitanya Kulkarni wrote:
> Looks good to me.
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> 
> On 05/09/2019 08:43 AM, Akinobu Mita wrote:
> > This removes three comments for struct nvme_telemetry_log_page_hdr.
> >
> > - The comment on top of the definision doesn't describe more than the
> >    struct name itself.
> >
> > - The rsvd1 field has already been verified.
> >
> > - The structures with trailing zero size array are commonly used in
> >    nvme-cli, so we don't need special comment for telemetry_dataarea[0].

Applied, thanks.
