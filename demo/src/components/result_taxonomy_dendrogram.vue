<template>
    <div>
        <link rel="import" href="http://togostanza.org/dist/metastanza/dendrogram/">
        <div id="contents">
            <div class="showcase_detail">
                <div class="showcase_box">
                    <togostanza-dendrogram v-if="scientific_name" :sparql_api="'http://togostanza.org/sparqlist/api/d3sparql_dendrogram?organism=' + scientific_name" title="D3 dendrogram"></togostanza-dendrogram>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import '@babel/polyfill'
    import '@webcomponents/webcomponentsjs'
    export default {
        name: 'dendrogram',
        props: {
            scientific_name:String
        },
    }
</script>
<style>
    /*@import "http://togostanza.org/dist/metastanza/assets/css/ts.css";*/
    .showcase_detail {
        background: #FCFCFC;
        margin-bottom: 5rem;
        padding: 2rem;
    }
</style>