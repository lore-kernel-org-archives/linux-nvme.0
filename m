From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 24 Oct 2018 22:19:43 +0000
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
In-Reply-To: <20181024215137.GA5138@localhost.localdomain>
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
 <20181019171713.GA25247@localhost.localdomain>
 <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>
 <20181024162209.GA4461@localhost.localdomain>
 <CAPrnrPDdBinRXG_18ZBJp+FkFT3EWPDM4xC0vhgg+tOoiDJGcg@mail.gmail.com>
 <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181024215137.GA5138@localhost.localdomain>
Message-ID: <7A7D3AF3-13B1-4569-BAC0-3689E5304F4E@wdc.com>

Hi Jeff,

-static int wdc_crash_dump(int fd, char *file)
+static int wdc_crash_dump(int fd, char *file, int type)
 {
        char f[PATH_MAX] = {0};
+       char dump_type[PATH_MAX] = {0};

Please follow the Keith's comment, "dump_type" should not use the PATH_MAX as this predefined macro is used to
hold the pathname for the file, so we need to change the dump_type.

Either allocate a memory for dump_type or defined a macro as it is suffix we don't have to copy string literal.

?On 10/24/18, 2:54 PM, "Linux-nvme on behalf of Keith Busch" <linux-nvme-bounces@lists.infradead.org on behalf of keith.busch@intel.com> wrote:

    On Wed, Oct 24, 2018@09:42:28PM +0000, Jeffrey Lien wrote:
    > Yea, the intent is to copy 11 bytes into the string.  The zero byte/space is not needed so memcpy is probably the better solution.  
    
    No, look again. The string terminator most certainly is needed the way
    you're using it. It happened to work out since you've initialized the
    temporary character array to all 0's, but there was no reason to even
    allocate 4k stack space to hold a copy of that string instead of using
    the pointing a 'const char *' directly to the literal.
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
