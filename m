From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 1 Sep 2018 20:40:01 +0000
Subject: [PATCH nvme-cli 2/4] fabrics: don't fail empty discovery log page
In-Reply-To: <20180901013605.10658-3-sagi@grimberg.me>
References: <20180901013605.10658-1-sagi@grimberg.me>
 <20180901013605.10658-3-sagi@grimberg.me>
Message-ID: <046A0967-916E-450A-B415-4C1ED1CBA2F8@wdc.com>

Looks good to me. (not sure if it matters but we can go up to 72 columns for commit log,
if it does can be fixed at the time of applying the patch).

Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.
?On 8/31/18, 6:37 PM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    It can be possible that discovery subsystem will not return
    any valid discovery records.
    
    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
    ---
     fabrics.c | 3 ++-
     1 file changed, 2 insertions(+), 1 deletion(-)
    
    diff --git a/fabrics.c b/fabrics.c
    index 28a3e3d9ac82..09cb97c5b880 100644
    --- a/fabrics.c
    +++ b/fabrics.c
    @@ -762,7 +762,8 @@ static int do_discover(char *argstr, bool connect)
     		fprintf(stderr, "Get discovery log entries failed.\n");
     		break;
     	case DISC_NO_LOG:
    -		fprintf(stderr, "No discovery log entries to fetch.\n");
    +		fprintf(stdout, "No discovery log entries to fetch.\n");
    +		ret = DISC_OK;
     		break;
     	case DISC_NOT_EQUAL:
     		fprintf(stderr,
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
