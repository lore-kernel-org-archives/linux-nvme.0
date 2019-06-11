From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Jun 2019 10:36:32 -0700
Subject: [PATCH V6 6/6] fabrics: Return errno mapped for fabrics error
 status
In-Reply-To: <20190611051309epcms2p1e47e656deb584057d428eaec018a363e@epcms2p1>
References: <7710edd4-5277-615c-426f-f9d48da8cb99@grimberg.me>
 <20190604154034.23386-1-minwoo.im.dev@gmail.com>
 <20190604154034.23386-7-minwoo.im.dev@gmail.com>
 <BYAPR04MB57497DFEEC77ED6D43998ED086110@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190608200112.GC28228@minwoo-900X5N>
 <CGME20190611000218epcas3p3270ae3bfaa97cd686a7006810c453988@epcms2p1>
 <20190611051309epcms2p1e47e656deb584057d428eaec018a363e@epcms2p1>
Message-ID: <667f4f9e-9356-44fb-d7fd-14d00b5393ea@grimberg.me>


>> Shouldn't we start over in this case?
> 
> I can see two functions are calling do_discover() which are:
>    1) case for discover_from_conf_file()
> 		err = do_discover(argstr, connect);
> 		if (err) {
> 			ret = err;
> 			continue;
> 		}
> 
>    2) case for discover()
> 		return do_discover(argstr, connect);
> 
> The 1) case might need non-zero values to start over by the user.  For the
> 2) case, it needs to be in zero value even it fails with entry count mismatch.
> 
> I would rather to have negative error value for the DISC_NOT_EQUAL case.
> Sagi, How about :
> 
> 	case DISC_NOT_EQUAL:
> 		ret = -EBADSLT;
> 		fprintf(stderr,
> 		"Numrec values of last two get discovery log page not equal\n");
> 		break;
> 

Question, this is a case where the numrec is different but the genctr is
the same? I think we need to fail if the genctr is the same, but we need
to start over if the genctr is different.
