From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 9 May 2019 15:15:39 +0900
Subject: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
In-Reply-To: <SN6PR04MB4527510BF05DCBF27E0B6D2F86330@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>
 <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CAA7jztfU+AdUHp5xo8ssjgvXiBFBXJt0PyQTNA8VQU-T-SpKQA@mail.gmail.com>
 <SN6PR04MB4527510BF05DCBF27E0B6D2F86330@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <CAA7jztcSAOTrPkiN+bDW5i7E1E0MA+xhU=6iZ-nEUy1YT2c1AQ@mail.gmail.com>

> Isn't this unsigned ? as pointed out by Keith ?
>
> $ cat a.c
> int main(void)
> {
>         return -1;
> }
> $ gcc a.c -o a
> $ ./a
> $ echo $?
> 255
>
> May be I'm missing something here ?

I meant that the program returns in a signed value, but it's going to be
parsed in 8bits which is unix style, I think.  Sorry for being unclear.
That's not enough to hold nvme status value at all.

> >
> > If you have any idea about it, Please let me know.  By the way, I really do
> > agree with what you mentioned about the return value.  If it's possible,
> > I would like to too :)
>
> How about we instead of returning the NVMe Status we map the NVMe Status
> of the program to the error code and in-turn return that error code ?
>
> The above is true only when command is successfully submitted from the
> program i.e. no errno is set by any library calls and failed in the
> completion queue entry with NVMe Status != NVME_SC_SUCCESS.
>
> For your reference In kernel we already do this detailed mapping where :-
>
> 1. Please refer to the drivers/nvme/target/core.c file where we map the
> errno_to_nvme_status(), the reverse mapping of that function can be done
> with nvme_status_to_errno(). Of course you will have to add more cases
> and do in-detail reverse error mapping from NVMe status to errno and
> return that errno.
> 2. nvme_error_status() we map NVMe Status to block layer status.
> 3. blk_status_to_errno() we map the block layer status to the errno.
>
> With the help of 1, 2 and 3 you can reverse map the NVMe Status to errno
> and add that mapper function for nvme-cli which will be consistent with
> the kernel NVMe status to errno mapping.
>
> Now you might find some cases where you cannot map all the status codes
> to errno and for those default cases you may end up using something like
> EIO, this is still better way than having to return 0.

Got your point. To make this discussion short, I think we need to make it
in nvme-cli first.  Let me have a discussion on the following link:
https://github.com/linux-nvme/nvme-cli/pull/492

Thanks,
