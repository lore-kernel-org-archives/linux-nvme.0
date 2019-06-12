From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 12 Jun 2019 21:26:46 +0900
Subject: [PATCH V6 6/6] fabrics: Return errno mapped for fabrics error
 status
In-Reply-To: <667f4f9e-9356-44fb-d7fd-14d00b5393ea@grimberg.me>
References: <7710edd4-5277-615c-426f-f9d48da8cb99@grimberg.me>
 <20190604154034.23386-1-minwoo.im.dev@gmail.com>
 <20190604154034.23386-7-minwoo.im.dev@gmail.com>
 <BYAPR04MB57497DFEEC77ED6D43998ED086110@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190608200112.GC28228@minwoo-900X5N>
 <CGME20190611000218epcas3p3270ae3bfaa97cd686a7006810c453988@epcms2p1>
 <20190611051309epcms2p1e47e656deb584057d428eaec018a363e@epcms2p1>
 <667f4f9e-9356-44fb-d7fd-14d00b5393ea@grimberg.me>
Message-ID: <20190612122646.GA32660@minwooim-desktop>

On 19-06-11 10:36:32, Sagi Grimberg wrote:
> 
> > > Shouldn't we start over in this case?
> > 
> > I can see two functions are calling do_discover() which are:
> >    1) case for discover_from_conf_file()
> > 		err = do_discover(argstr, connect);
> > 		if (err) {
> > 			ret = err;
> > 			continue;
> > 		}
> > 
> >    2) case for discover()
> > 		return do_discover(argstr, connect);
> > 
> > The 1) case might need non-zero values to start over by the user.  For the
> > 2) case, it needs to be in zero value even it fails with entry count mismatch.
> > 
> > I would rather to have negative error value for the DISC_NOT_EQUAL case.
> > Sagi, How about :
> > 
> > 	case DISC_NOT_EQUAL:
> > 		ret = -EBADSLT;
> > 		fprintf(stderr,
> > 		"Numrec values of last two get discovery log page not equal\n");
> > 		break;
> > 
> 
> Question, this is a case where the numrec is different but the genctr is
> the same? I think we need to fail if the genctr is the same, but we need
> to start over if the genctr is different.

This is the case where you pointed it out.  But we don't know if
genctr is different or not because we don't have any notifying code
in nvmf_get_log_page_discovery().  Even genctr is different but the
retries count is exhausted to max_retries, it does not notify this
situation to the caller to retry it.

Would you mind if the following patch is added to this series?  If not, we
need to change the design concept which tries to avoid infinite loop that
had been introduced by Hannes's commit 3cbcd165b47.

---
diff --git a/fabrics.c b/fabrics.c
index 81c2d9d..8a65bca 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -292,6 +292,7 @@ enum {
        DISC_NO_LOG,
        DISC_GET_NUMRECS,
        DISC_GET_LOG,
+       DISC_RETRY_EXHAUSTED,
        DISC_NOT_EQUAL,
 };
 
@@ -386,6 +387,16 @@ static int nvmf_get_log_page_discovery(const char *dev_path,
        } while (genctr != le64_to_cpu(log->genctr) &&
                 ++retries < max_retries);
 
+       /*
+        * If genctr is still different with the one in the log entry, it
+        * means the retires have been exhausted to max_retries.  Then it
+        * should be retried by the caller or the user.
+        */
+       if (genctr != le64_to_cpu(log->genctr)) {
+               error = DISC_RETRY_EXHAUSTED;
+               goto out_free_log;
+       }
+
        if (*numrec != le32_to_cpu(log->numrec)) {
                error = DISC_NOT_EQUAL;
                goto out_free_log;
@@ -887,6 +898,10 @@ static int do_discover(char *argstr, bool connect)
                fprintf(stdout, "No discovery log entries to fetch.\n");
                ret = DISC_OK;
                break;
+       case DISC_RETRY_EXHAUSTED:
+               fprintf(stdout, "Discovery retries exhausted.\n");
+               ret = -EAGAIN;
+               break;
        case DISC_NOT_EQUAL:
                fprintf(stderr,
                "Numrec values of last two get discovery log page not equal\n");


If I'm missing something here, please let me know. 
