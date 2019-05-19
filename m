From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 20 May 2019 02:53:16 +0900
Subject: [PATCH V2 3/4] nvme: Return errno mapped for nvme error status
In-Reply-To: <BYAPR04MB574936E1FDF464243691513286050@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
 <20190513170342.9497-4-minwoo.im.dev@gmail.com>
 <BYAPR04MB574936E1FDF464243691513286050@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <20190519175315.GA10876@minwooim-desktop>

> > @@ -364,6 +367,7 @@ static int get_telemetry_log(int argc, char **argv, struct command *cmd, struct
> >   		perror("get-telemetry-log");
> >   	else if (err > 0) {
> >   		show_nvme_status(err);
> > +		err = nvme_status_to_errno(err, false);
> >   		fprintf(stderr, "Failed to acquire telemetry header %d!\n", err);
> 
> Following line to nvme_status_to_errno() call above assumes that err has 
> a return value from nvme_get_telemetry_log() and we are overwriting it.
> 
> We need to avoid such scenarios going forward. Also, since each command 

Can you please explain why we need to avoid such overwriting scenario?

> assumes that err holds the NVMe status. Instead of having to call 
> nvme_status_errno() along with nvme_show_status() we should call 
> nvme_status_to_errno(err) at the end of the function in the return 
> statement. This approach will not break the assumption that code is 
> having now and less lines of code changes, obviously 
> nvme_status_to_errno() will need some modifications but that
> is fine, untested patch following  :-

Makes sense.  If we are going to convert the positive nvme status and
negative linux internal errno status to an errno inside of
nvme_st4atus_to_errno(), it will much more simpler for this patch.

Anyway, I will prepare V3 patch by updating the conversion at the end of
the each subcommandh handlers.
